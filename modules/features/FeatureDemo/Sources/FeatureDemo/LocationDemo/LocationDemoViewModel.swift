// **********************************************************
//    Copyright © 2024 Johnnie Cheng. All rights reserved.
// **********************************************************

import Combine
import Common
import CoreLocation

public class LocationDemoViewModel: ObservableObject {
    
    @Published var authString: String
    @Published var location: CLLocation?
    @Published var address: String?
    private let locationManager: LocationManagerProtocol
    
    private var subscriptions = Set<AnyCancellable>()
    
    public init(
        locationManager: LocationManagerProtocol = LocationManager.default
    ) {
        self.locationManager = locationManager
        self.authString = locationManager.currentPermissionStatus.description
        
        startObservingLocationPermission()
    }
    
    private func startObservingLocationPermission() {
        locationManager.locationPermissionStatusPublisher
            .sink { [weak self] permissionChange in
                self?.authString = permissionChange.status.description
            }
            .store(in: &subscriptions)
    }
    
    func requestLocationPermission() {
        locationManager.requestLocationPermission()
    }

    @MainActor func requestLocation() {
        location = nil
        address = nil
        Task {
            location = await locationManager.getOneOffLocation()
            address = await location?.address
        }
    }
    
}

fileprivate extension CLAuthorizationStatus {
    
    var description: String {
        switch self {
        case .authorizedAlways:
            return "authorizedAlways"
        case .authorizedWhenInUse:
            return "authorizedWhenInUse"
        case .denied:
            return "denied"
        case .notDetermined:
            return "notDetermined"
        case .restricted:
            return "restricted"
        @unknown default:
            return "unknown"
        }
    }
    
}
