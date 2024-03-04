// **********************************************************
//    Copyright © 2024 Johnnie Cheng. All rights reserved.
// **********************************************************

import UIKit
import Combine
import CoreLocation

public protocol LocationManagerProtocol {
    
    var locationPermissionStatusPublisher: AnyPublisher<LocationPermissionStatusChange, Never> { get }
    var locationPublisher: AnyPublisher<CLLocation?, Never> { get }
    var headingPublisher: AnyPublisher<CLHeading?, Never> { get }
    var errorPublisher: AnyPublisher<Error, Never> { get }
    
    var currentPermissionStatus: CLAuthorizationStatus { get }
    var hasWhenInUsePersmission: Bool { get }
    var hasAlwaysPermission: Bool { get }
    var hasAnyPermission: Bool { get }
    
    func requestLocationPermission()
    
    func getOneOffLocation() async -> CLLocation?
    
    /// request updaing location, location will be send through [locationPublisher]
    func startUpdatingLocation()
    func stopUpdatingLocation()
    
    /// request updaing heading, location will be send through [headingPublisher]
    func startUpdatingHeading()
    func stopUpdatingHeading()
    
}

public class LocationManager: NSObject, LocationManagerProtocol {
    
    public static let `default` = LocationManager()
    
    private let locationManager: CLLocationManager
    
    private var isRequestingLocation = false
    private var isRequestingLocationPermission = false
    var isUpdatingLocation = false
    var isUpdatingHeading = false
    
    private var oneOffLocationContinuations = [CheckedContinuation<CLLocation?, Never>]()
    
    
    private let locationPermissionStatusSubject = PassthroughSubject<LocationPermissionStatusChange, Never>()
    lazy public var locationPermissionStatusPublisher = locationPermissionStatusSubject
        .share()
        .eraseToAnyPublisher()
    
    private let locationSubject = PassthroughSubject<CLLocation?, Never>()
    lazy public var locationPublisher = locationSubject
        .share()
        .eraseToAnyPublisher()
    
    private let headingSubject = PassthroughSubject<CLHeading?, Never>()
    lazy public var headingPublisher = headingSubject
        .share()
        .eraseToAnyPublisher()
    
    private let errorSubject = PassthroughSubject<Error, Never>()
    lazy public var errorPublisher = errorSubject
        .share()
        .eraseToAnyPublisher()
    
    init(
        locationManager: CLLocationManager = LocationManager.defaultLocationManager
    ) {
        self.locationManager = locationManager
        super.init()
        
        self.locationManager.delegate = self
    }
    
    public var currentPermissionStatus: CLAuthorizationStatus {
        locationManager.authorizationStatus
    }
    
    public var hasWhenInUsePersmission: Bool {
        locationManager.authorizationStatus == .authorizedWhenInUse
    }
    
    public var hasAlwaysPermission: Bool {
        locationManager.authorizationStatus == .authorizedAlways
    }
    
    public var hasAnyPermission: Bool { hasWhenInUsePersmission ||  hasAlwaysPermission }
    
    public func requestLocationPermission() {
        DispatchQueue.main.async {
            if self.locationManager.authorizationStatus == .notDetermined {
                self.isRequestingLocationPermission = true
            }
            self.locationManager.requestWhenInUseAuthorization()
        }
    }
    
    public func getOneOffLocation() async -> CLLocation? {
        await withCheckedContinuation { [weak self] continuation in
            guard let self = self else { return }
            
            self.oneOffLocationContinuations.append(continuation)
            Task { await self.getLocation() }
        }
    }
    
    public func startUpdatingLocation() {
        let status = self.locationManager.authorizationStatus
        guard status == .authorizedAlways || status == .authorizedWhenInUse else {
            // TODO: throw error
            return
        }
        
        Task { await self.performStartUpdatingLocation() }
    }
    
    public func stopUpdatingLocation() {
        Task { await self.performStopUpdatingLocation() }
    }
    
    public func startUpdatingHeading() {
        let status = self.locationManager.authorizationStatus
        
        guard CLLocationManager.headingAvailable() else {
            // TODO: throw error
            return
        }
        
        guard status == .authorizedAlways || status == .authorizedWhenInUse else {
            // TODO: throw error
            return
        }
        
        Task { await self.performStartUpdatingLocation() }
    }
    
    public func stopUpdatingHeading() {
        Task { await self.performStopUpdatingHeading() }
    }
    
    @MainActor
    private func getLocation() {
        if !isRequestingLocation {
            isRequestingLocation = true
            locationManager.requestLocation()
        }
    }
    
    @MainActor
    private func performStartUpdatingLocation() {
        guard !isUpdatingLocation else { return }
        
        isUpdatingLocation = true
        locationManager.startUpdatingLocation()
    }
    
    @MainActor
    private func performStopUpdatingLocation() {
        isUpdatingLocation = false
        locationManager.stopUpdatingLocation()
    }
    
    @MainActor
    private func performStartUpdatingHeading() {
        guard !isUpdatingHeading else { return }
        
        isUpdatingHeading = true
        locationManager.startUpdatingHeading()
    }
    
    @MainActor
    private func performStopUpdatingHeading() {
        isUpdatingHeading = false
        locationManager.stopUpdatingHeading()
    }
    
    @MainActor fileprivate func didGetLocation(_ location: CLLocation?) {
        locationSubject.send(location)
        
        while !oneOffLocationContinuations.isEmpty {
            let ontinuations = oneOffLocationContinuations.popLast()
            ontinuations?.resume(returning: location)
        }
    }
    
    @MainActor fileprivate func didGetHeading(_ newHeading: CLHeading) {
        headingSubject.send(newHeading)
    }
    
    @MainActor fileprivate func didFailWithError(_ error: Error) {
        errorSubject.send(error)
    }
    
}

extension LocationManager: CLLocationManagerDelegate {
    
    public func locationManager(
        _ manager: CLLocationManager,
        didChangeAuthorization status: CLAuthorizationStatus
    ) {
        locationPermissionStatusSubject.send(
            LocationPermissionStatusChange(
                status: status,
                isChangedFromPrompt: isRequestingLocationPermission
            )
        )
        
        isRequestingLocationPermission = false
    }
    
    public func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        isRequestingLocation = false
        Task {
            await didGetLocation(manager.location)
        }
    }
    
    public func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        isRequestingLocation = false
        Task {
            await didGetLocation(nil)
            await didFailWithError(error)
        }
    }
    
    public func locationManager(
        _ manager: CLLocationManager,
        didUpdateHeading newHeading: CLHeading
    ) {
        Task { await didGetHeading(newHeading) }
    }
    
}

fileprivate extension LocationManager {
    
    static let defaultLocationManager: CLLocationManager = {
        func createLocationManager() -> CLLocationManager {
            let manager = CLLocationManager()
            manager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
            
            return manager
        }
        
        // make sure locationManager is init on main thread
        // otherwise, delegate functions will not be called
        if Thread.isMainThread {
            return createLocationManager()
        } else {
            return DispatchQueue.main.sync {
                createLocationManager()
            }
        }
    }()
    
}

public struct LocationPermissionStatusChange {
    
    public let status: CLAuthorizationStatus
    
    /// true when use interact with permission prompt
    /// false for other cases, most likely from OS setting
    public let isChangedFromPrompt: Bool
    
}
