//
//  LocationObject.swift
//  Location
//
//  Created by Fineas Gavre on 15.09.2020.
//  Copyright © 2020 Fineas Gavre. All rights reserved.
//

import Foundation
import RealmSwift

// MARK: - Location struct

struct Location: Decodable {
    var id: String
    let latitude: Double
    let longitude: Double
    let label: String
    let address: String
    let image: String?
    
    private enum CodingKeys: String, CodingKey {
        case latitude, longitude, label, address, image, lat, lng
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        label = try container.decode(String.self, forKey: .label)
        id = label
        address = try container.decode(String.self, forKey: .address)
        image = try container.decodeIfPresent(String.self, forKey: .image)
        
        if let decodedLatitude = try container.decodeIfPresent(Double.self, forKey: .latitude) {
            latitude = decodedLatitude
        } else {
            latitude = try container.decode(Double.self, forKey: .lat)
        }
        
        if let decodedLongitude = try container.decodeIfPresent(Double.self, forKey: .longitude) {
            longitude = decodedLongitude
        } else {
            longitude = try container.decode(Double.self, forKey: .lng)
        }
    }
}

// MARK: - RealmLocation convenience init extension

extension RealmLocation {
    convenience init(_ location: Location) {
        self.init()
        self.id = location.label
        self.latitude = location.latitude
        self.longitude = location.longitude
        self.label = location.label
        self.address = location.address
        self.image = location.image
    }
}

// MARK: - Location RealmConvertible extension

extension Location: RealmConvertible {
    func realmMap() -> RealmLocation {
        RealmLocation(self)
    }
    
    init(_ realmLocation: RealmLocation) {
        self.id = realmLocation.id
        self.latitude = realmLocation.latitude
        self.longitude = realmLocation.longitude
        self.label = realmLocation.label
        self.address = realmLocation.address
        self.image = realmLocation.image
    }
}



