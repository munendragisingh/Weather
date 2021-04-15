//
//  DBManager.swift
//  Weather
//
//  Created by Pratap SIngh on 14/04/21.
//

import Foundation
import RealmSwift

class DBManager {
    
    private func getRealm() -> Realm {
        let realm = try! Realm()
        return realm
    }
    
     func isCountryInLocal() -> Bool{
        let realm = getRealm()
        let tasks = realm.objects(City.self)
        return tasks.count > 0
    }
    
    func saveCountry(city: List<City>) {
        let realm = getRealm()
        try! realm.write {
            realm.add(city)
        }
    }
    
    func filter(city: String) -> Array<City> {
        let realm = getRealm()
        let city = realm.objects(City.self).filter("name CONTAINS[c] %@", city)
        return Array(city)
    }
    
    func searchSelectedCity() -> Array<City> {
        let realm = getRealm()
        let city = realm.objects(City.self).filter("isSlected=true")
        return Array(city)
    }
    
    func setDefaultCity() {
        let realm = getRealm()
        let city = realm.objects(City.self).filter("id=1267995").last
        try! realm.write {
            city?.isSlected = true
        }
    }
    
    func getCountry() {
        print()
    }
    
}