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
        let theta = longitude1 - longitude2
        var distance = sin(latitude1.toRadians()) * sin(latitude2.toRadians()) + cos(latitude1.toRadians()) * cos(latitude2.toRadians()) * cos(theta.toRadians())
        distance = acos(distance)
        distance = distance.toDegrees()
        
        // Transform the distance into kilometers
        distance = distance * 1.609344
        
        return distance
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


