//
//  HomeViewModel.swift
//  Weather
//
//  Created by Pratap SIngh on 15/04/21.
//

import Foundation

class HomeViewModel {
    let dbManager = DBManager()
    private var selectedCity: Array<City> = []
    private var weatherViewModel: Array<WeatherViewModel> = []
    
    init() {
        selectedCity = dbManager.searchSelectedCity()
        for city in selectedCity {
            weatherViewModel.append(WeatherViewModel(city: city))
        }
    }
    
    /// return number of section in table view
    var numberOfSection: Int {
        return 1
    }
    
    /// return number of rows in section
    var numberOfRowsInSection: Int {
        return weatherViewModel.count
    }
    
    /// return current city
    var getSelectedCity: Array<City> {
        return selectedCity
    }
    
    
    func cityViewModel(index: Int) -> WeatherViewModel {
        return weatherViewModel[index]
    }
    /// reload city data
    func addCity(city: City?)  {
        if let cityObj = city {
            weatherViewModel.append(WeatherViewModel(city: cityObj))
            selectedCity.append(cityObj)
        }
    }
    
    /// remove city cell from tableview and mark it as on selected
    /// - Parameter index: index of city
    func removeCity(index:Int) {
        let city = selectedCity[index]
        if !city.isInvalidated {
            dbManager.deSelectCity(city: city)
            selectedCity.remove(at: index)
            weatherViewModel.remove(at: index)
            
        }
    }
    
}
