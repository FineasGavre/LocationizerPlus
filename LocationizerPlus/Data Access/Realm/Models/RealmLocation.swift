//
//  RealmLocation.swift
//  LocationizerPlus
//
//  Created by Fineas Gavre on 16.09.2020.
//

import Foundation
import RealmSwift

class RealmLocation: Object, StringIdentifiable {
    @objc dynamic var id: String = ""
    @objc dynamic var latitude: Double = 0.0
    @objc dynamic var longitude: Double = 0.0
    @objc dynamic var label = ""
    @objc dynamic var address = ""
    @objc dynamic var image: String? = nil

    override class func primaryKey() -> String? {
        return "id"
    }
}
