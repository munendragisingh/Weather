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
        saveCityJSONToDB()
    }

    override func tearDownWithError() throws {
        print()
    }

    func testExample() throws {
        let city = City(id: 234233, name: "ffsd", state: "sdfsd", country: "IN", isSlected: true, coord: Coordinate(lat: 34.3423, lon: 54.24423))
        
        viewModel.addCity(city: city)
        XCTAssertEqual(viewModel.numberOfSection, 1, "section should be 1")
        XCTAssertGreaterThan(viewModel.numberOfRowsInSection, 0, "row's should be greater then 0")
        XCTAssertGreaterThan(viewModel.getSelectedCity.count, 0, "selected cities should be greater then 0")
        viewModel.removeCity(index: 0)
        dbManager.deleteAll()
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
                dbManager.selectCity(city: city)
              } catch {
                print(error.localizedDescription)
              }
        }
    }
    
}
