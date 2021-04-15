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
    
    var numberOfSection: Int {
        return 1
    }
    
    var numberOfRowsInSection: Int {
        return selectedCity.count
    }
    
    var getSelectedCity: Array<City> {
        return selectedCity
    }
    
}
