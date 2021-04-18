//
//  HomeViewModel.swift
//  Weather
//
//  Created by Pratap SIngh on 15/04/21.
//

import Foundation

class HomeViewModel {
    let dbManager = DBManager()
    var selectedCity: Array<City> = []
    
    init() {
        selectedCity = dbManager.searchSelectedCity()
    }
    
    /// return number of section in table view
    var numberOfSection: Int {
        return 1
    }
    
    /// return number of rows in section
    var numberOfRowsInSection: Int {
        return selectedCity.count
    }
    
    /// return current city
    var getSelectedCity: Array<City> {
        return selectedCity
    }
    
    /// reload city data
    func reloadSelectedCity()  {
        selectedCity = dbManager.searchSelectedCity()
    }
    
    /// remove city cell from tableview and mark it as on selected
    /// - Parameter index: index of city
    func removeCity(index:Int) {
        let city = selectedCity[index]
        dbManager.deSelectCity(city: city)
        selectedCity.remove(at: index)
    }
    
}
