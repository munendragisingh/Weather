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
    
     func isCityInLocal() -> Bool{
        let realm = getRealm()
        let tasks = realm.objects(City.self)
        return tasks.count > 0
    }
    
    func saveCity(city: List<City>) {
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
        let sydney = realm.objects(City.self).filter("id=4163971").last
        let melbourne = realm.objects(City.self).filter("id=2147714").last
        let brisbane = realm.objects(City.self).filter("id=2174003").last
        try! realm.write {
            sydney?.isSlected = true
            melbourne?.isSlected = true
            brisbane?.isSlected = true
        }
    }
    
    func getAllCity() -> Array<City> {
        let realm = getRealm()
        let cities = realm.objects(City.self)
        return Array(cities)
    }
    
    func getAllUnselectedCity() -> Array<City> {
        let realm = getRealm()
        let cities = realm.objects(City.self).filter(NSPredicate(format: "isSlected = false"))
        return Array(cities)
    }
    
    func selectCity(city: City) {
        let realm = getRealm()
        realm.beginWrite()
        do {
                city.isSlected = true
            try realm.commitWrite()
        } catch  {
            print(error.localizedDescription)
        }
        
    }
    
    func deSelectCity(city: City) {
        let realm = getRealm()
        realm.beginWrite()
        do {
            city.isSlected = false
            try realm.commitWrite()
        } catch  {
            print(error.localizedDescription)
        }
    }
    
}
