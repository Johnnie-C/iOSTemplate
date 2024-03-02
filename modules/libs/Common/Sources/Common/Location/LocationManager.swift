// **********************************************************
//    Copyright © 2024 Johnnie Cheng. All rights reserved.
// **********************************************************

import UIKit
import Combine
import CoreLocation

public protocol LocationManagerProtocol {
    
    var locationPermissionStatusPublisher: AnyPublisher<LocationPermissionStatusChange, Never> { get }
    var locationPublisher: AnyPublisher<CLLocation?, Never> { get }
    
    func requestLocationPermission()
    
    
    /// request one off location, location will be send through [locationPublisher]
    func getOneOffLocation()
    
}

public class LocationManager: NSObject, LocationManagerProtocol {
    
    static let `default` = LocationManager()
    
    private var isRequestingLocation = false
    private var isRequestingLocationPermission = false
    
    private let locationPermissionStatusSubject = PassthroughSubject<LocationPermissionStatusChange, Never>()
    lazy public var locationPermissionStatusPublisher = locationPermissionStatusSubject
        .share()
        .eraseToAnyPublisher()
    
    private let locationSubject = PassthroughSubject<CLLocation?, Never>()
    lazy public var locationPublisher = locationSubject
        .share()
        .eraseToAnyPublisher()
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    private let locationManager: CLLocationManager = {
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
    
    public func requestLocationPermission() {
        DispatchQueue.main.async {
            if self.locationManager.authorizationStatus == .notDetermined {
                self.isRequestingLocationPermission = true
            }
            self.locationManager.requestWhenInUseAuthorization()
        }
    }
    
    public func getOneOffLocation() {
        let status = self.locationManager.authorizationStatus
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            Task { await self.getLocation() }
        }
    }
    
    @MainActor
    private func getLocation() {
        if !isRequestingLocation {
            isRequestingLocation = true
            locationManager.requestLocation()
        }
    }
    
    @MainActor fileprivate func didGetLocation(_ location: CLLocation?) {
        locationSubject.send(location)
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
        Task { await didGetLocation(nil) }
    }
    
}

public struct LocationPermissionStatusChange {
    
    public let status: CLAuthorizationStatus
    
    /// true when use interact with permission prompt
    /// false for other cases, most likely from OS setting
    public let isChangedFromPrompt: Bool
    
}
