//
//  RealmHelper.swift
//  LocationizerPlus
//
//  Created by Fineas Gavre on 16.09.2020.
//

import RealmSwift

class RealmHelper {
    
    // MARK: - Static Properties
    
    static let shared = RealmHelper()
    
    // MARK: - Private Properties
    
    private let realm: Realm
    
    // MARK: - Initializers
    
    private init() {
        realm = try! Realm()
    }
    
    // MARK: - Public Methods
    
    func get<ObjectType: Object & StringIdentifiable>(_ object: ObjectType) -> ObjectType? {
        realm.object(ofType: ObjectType.self, forPrimaryKey: object.id)
    }
    
    func create<ObjectType: Object & StringIdentifiable>(_ object: ObjectType) throws {
        guard realm.object(ofType: ObjectType.self, forPrimaryKey: object.id) == nil else { return }
        
        try realm.write {
            realm.add(object)
        }
    }
    
    func update<ObjectType: Object>(_ object: ObjectType) throws {
        try realm.write {
            realm.create(ObjectType.self, value: object, update: .modified)
        }
    }
    
    func updateConvertible<Convertible: RealmConvertible>(_ convertible: Convertible) throws {
        try realm.write {
            realm.create(Convertible.RealmType.self, value: convertible.realmMap(), update: .modified)
        }
    }
    
    func updateConvertibleIgnoringErrors<Convertible: RealmConvertible>(_ convertible: Convertible) {
        try? realm.write {
            realm.create(Convertible.RealmType.self, value: convertible.realmMap(), update: .modified)
        }
    }
    
    func delete<ObjectType: Object & StringIdentifiable>(_ object: ObjectType) throws {
        guard let realmObject = get(object) else { return }
        
        try realm.write {
            realm.delete(realmObject)
        }
    }
    
    func deleteConvertible<Convertible: RealmConvertible>(_ convertible: Convertible) throws {
        guard let realmObject = get(convertible.realmMap()) else { return }
        
        try realm.write {
            realm.delete(realmObject)
        }
    }

    func list<ObjectType: Object>(_ objectType: ObjectType.Type) -> RealmSwift.Results<ObjectType> {
        realm.objects(objectType)
    }
    
    func clearAllData() throws {
        try realm.write {
            realm.deleteAll()
        }
    }
    
}
