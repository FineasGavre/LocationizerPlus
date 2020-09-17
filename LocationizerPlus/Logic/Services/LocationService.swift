//
//  LocationService.swift
//  Location
//
//  Created by Fineas Gavre on 15.09.2020.
//  Copyright © 2020 Fineas Gavre. All rights reserved.
//

import Foundation
import Combine
import CoreLocation

class LocationService: NSObject, ObservableObject {
    
    // MARK: - Public Properties
    
    @Published var userCoordinates: CLLocationCoordinate2D?
    @Published var locations = DataObservable<Location>()
    
    // MARK: - Private Properties
    
    private let locationManager = CLLocationManager()
    private let locationFetcher = LocationFetcher()
    private var cancellableSet = Set<AnyCancellable>()
    
    // MARK: - Initializers
    
    override init() {
        super.init()
        
        askUserForLocationAuthorization()
    }
    
    // MARK: - Public Methods
    
    func fetchRemoteLocationsAndSaveIntoRealm() {
        locationFetcher.fetchLocationsFromServer().sink { (locations) in
            locations.forEach { (location) in
                do {
                    try RealmHelper.shared.create(location.realmMap())
                } catch {
                    print("Error occurred when creating a location: \(error.localizedDescription)")
                }
            }
        }.store(in: &cancellableSet)
    }
    
    func removeAllLocationsFromRealm() {
        do {
            try RealmHelper.shared.clearAllData()
        } catch {
            print("An error has occurred when clearing data from the Realm.")
        }
    }
    
    func getNearestLocationFrom(latitude: Double, longitude: Double) -> Location? {
        locations.items.min { (location1, location2) -> Bool in
            return CoordinateHelper.distanceBetweenTwoCoordinates(latitude1: latitude, longitude1: longitude, latitude2: location1.latitude, longitude2: location1.longitude) < CoordinateHelper.distanceBetweenTwoCoordinates(latitude1: latitude, longitude1: longitude, latitude2: location2.latitude, longitude2: location2.longitude)
        }
    }
    
    func getUserDistanceToLocation(location: Location) -> Double? {
        guard let userCoordinates = userCoordinates else { return nil }
        
        return CoordinateHelper.distanceBetweenTwoCoordinates(latitude1: userCoordinates.latitude, longitude1: userCoordinates.longitude, latitude2: location.latitude, longitude2: location.longitude)
    }
    
    func askUserForLocationAuthorization() {
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    // MARK: - Private Methods


}

// MARK: - CLLocationManagerDelegate extension

extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locationValue = manager.location?.coordinate else { return }
        
        userCoordinates = locationValue
    }
}
