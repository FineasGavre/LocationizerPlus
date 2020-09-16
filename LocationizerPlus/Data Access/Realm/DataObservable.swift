//
//  DataObservable.swift
//  LocationizerPlus
//
//  Created by Fineas Gavre on 16.09.2020.
//

import SwiftUI
import RealmSwift

class DataObservable<Type: RealmConvertible>: ObservableObject {
    
    // MARK: - Private Properties

    private var notificationTokens: [NotificationToken] = []
    private var realmItems: RealmSwift.Results<Type.RealmType>
    
    // MARK: - Published Properties
    
    @Published private(set) var items: [Type]
    
    // MARK: - Initialisers
    
    init() {
        realmItems = RealmHelper.shared.list(Type.RealmType.self)
        items = realmItems.map { Type($0) }
        
        watchRealm()
    }
    
    // MARK: - Private Methods
    
    private func watchRealm() {
        self.notificationTokens.append(realmItems.observe({ _ in
            self.updateItems()
        }))
    }
    
    private func updateItems() {
        DispatchQueue.main.async {
            self.items = self.realmItems.map { Type($0) }
        }
    }
    
    // MARK: - Deinitialisers
    
    deinit {
        notificationTokens = []
    }
}
