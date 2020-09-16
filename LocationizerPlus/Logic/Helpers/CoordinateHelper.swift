//
//  CoordinateHelper.swift
//  Locationizer
//
//  Created by Fineas Gavre on 16.09.2020.
//  Copyright © 2020 Fineas Gavre. All rights reserved.
//

import Foundation

class CoordinateHelper {
    // Returns the distance between two coordinates in kilometers using the haversine formula
    static func distanceBetweenTwoCoordinates(latitude1: Double, longitude1: Double, latitude2: Double, longitude2: Double) -> Double {
        let rlatitude1 = latitude1.toRadians()
        let rlongitude1 = longitude1.toRadians()
        let rlatitude2 = latitude2.toRadians()
        let rlongitude2 = longitude2.toRadians()
        
        let dlatitude = rlatitude2 - rlatitude1
        let dlongitude = rlongitude2 - rlongitude1
        
        let a = sin(dlatitude/2) * sin(dlatitude/2) + cos(latitude1) * cos(latitude2) * sin(dlongitude/2) * sin(dlongitude/2)
        let c = 2 * asin(sqrt(a))
        let r = 6371.0 // Radius of the Earth in km
        
        return c * r
    }
}

extension Double {
    func toRadians() -> Double {
        self * .pi / 180.0
    }
    
    func toDegrees() -> Double {
        self * 180.0 / .pi
    }
}


