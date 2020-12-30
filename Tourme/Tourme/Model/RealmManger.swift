//
//  RealmManger.swift
//  Tourme
//
//  Created by Dua Almahyani on 29/12/2020.
//

import Foundation
import RealmSwift

class RealmManager {
    
    class func setRealmConfiguration() {
        
        let config = Realm.Configuration(
            
            // encryptionKey: key,
           
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: 1,
            
//             Set the block which will be called automatically when opening a Realm with
//             a schema version lower than the one set above
            migrationBlock: { migration, oldSchemaVersion in
//                if (oldSchemaVersion < 1) {
//                    migration.deleteData(forType: "Person")
//                }
//                if (oldSchemaVersion < 1) {
//                    migration.enumerateObjects(ofType: "Person") { oldObject, newObject in
//                        let stringValue = oldObject?["age"] as? String ?? ""
//                        newObject?["age"] = Int(stringValue) ?? 0
//                    }
//                }

    })
        
        Realm.Configuration.defaultConfiguration = config
    }
    
}

//MARK:- Private Functions
extension RealmManager {

    func saveBusiness(_ business: Business) -> Bool {

        guard let realm = try? Realm() else { return false }

        do{
            try realm.write {
                realm.create(Business.self, value: business, update: .modified)
            }
        }catch{
            return false
        }
        return true

    }

    func getAllBusinesses() -> Results<Business>? {

        guard let realm = try? Realm() else { return nil }

        let results = realm.objects(Business.self)
        return results

    }

}
