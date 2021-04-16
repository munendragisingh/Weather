//
//  SearchModel.swift
//  Weather
//
//  Created by Pratap SIngh on 15/04/21.
//

import Foundation

class SearchViewModel {
    private let dbManager = DBManager()
    private var selectedCity: Array<City> = []
    private var filterCity: Array<City> = []
    
    init() {
        selectedCity = dbManager.getAllCity()
        filterCity = selectedCity
    }
    
    var numberOfRowsInSection: Int {
        return filterCity.count
    }
    
    func filter(with string:String) -> Array<City> {
        if string.count == 0 {
            filterCity = selectedCity
        }else{
            let predicate = NSPredicate(format: "name CONTAINS[c] %@", string)
            filterCity = selectedCity.filter{ predicate.evaluate(with: $0)  }
        }
        return filterCity
    }
    
    func cityAt(index: Int) -> City {
        return filterCity[index]
    }
    
    func selectCity(at index: Int) {
        let city = cityAt(index: index)
        dbManager.selectCity(city: city)
    }
    
}
