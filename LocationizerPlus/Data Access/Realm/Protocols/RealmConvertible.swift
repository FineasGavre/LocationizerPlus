//
//  RealmConvertible.swift
//  LocationizerPlus
//
//  Created by Fineas Gavre on 16.09.2020.
//

import Foundation
import RealmSwift
import SwiftUI

protocol RealmConvertible where Self: Equatable & StringIdentifiable {
    associatedtype RealmType: Object & StringIdentifiable
    
    func realmMap() -> RealmType
    init(_ realmType: RealmType)
}

extension RealmConvertible {
    func realmBinding() -> Binding<Self> {
        return Binding<Self>(get: {
            if let realmObject = RealmHelper.shared.get(self.realmMap()) {
                return Self(realmObject)
            } else {
                return self
            }
        }, set: RealmHelper.shared.updateConvertible)
    }
}
