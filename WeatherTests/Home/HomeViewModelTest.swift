//
//  HomeViewModelTest.swift
//  WeatherTests
//
//  Created by Pratap SIngh on 18/04/21.
//

import XCTest
import RealmSwift

@testable import Weather

class HomeViewModelTest: XCTestCase {
    let viewModel = HomeViewModel()
    private let dbManager = DBManager()
    
    override func setUpWithError() throws {
//        dbManager.deleteAll()
        saveCityJSONToDB()
    }

    override func tearDownWithError() throws {
        dbManager.deleteAll()
    }

    func testExample() throws {
        viewModel.removeCity(index: 0)
        viewModel.reloadSelectedCity()
        XCTAssertGreaterThan(viewModel.numberOfSection, 0, "section should be 1")
        XCTAssertGreaterThan(viewModel.numberOfRowsInSection, 0, "row's should be 1")
        XCTAssertGreaterThan(viewModel.getSelectedCity.count, 0, "row's should be 1")
        
    }
    
    private func saveCityJSONToDB() {
        if let path = Bundle.main.path(forResource: "city_list", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                guard let users = try? JSONDecoder().decode(List<City>.self, from: data) else {
                    return
                }
                guard let city = users.last else { return  }
                users.removeAll()
                users.append(city)
                dbManager.saveCity(city: users)
              } catch {
                print(error.localizedDescription)
              }
        }
    }
    
}
