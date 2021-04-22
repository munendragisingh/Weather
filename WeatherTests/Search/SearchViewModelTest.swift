//
//  SearchViewModel.swift
//  WeatherTests
//
//  Created by Pratap SIngh on 22/04/21.
//

import XCTest
import RealmSwift

@testable import Weather

class SearchViewModelTest: XCTestCase {
    
    let searchViewModel = SearchViewModel()
    private var cityName: String = ""
    
    override func setUpWithError() throws {
        saveCityJSONToDB()

    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let city = searchViewModel.cityAt(index: 0)
        XCTAssertNotNil(city)
        XCTAssertGreaterThan(searchViewModel.numberOfRowsInSection, 0, "row's should be greater then 0")
        let list = searchViewModel.filter(with: cityName)
        XCTAssertGreaterThan(list.count, 0, "list.count should be greater then 1")
    }

    private func saveCityJSONToDB() {
        let dbManager = DBManager()
        if let path = Bundle.main.path(forResource: "city_list", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                guard let users = try? JSONDecoder().decode(List<City>.self, from: data) else {
                    return
                }
                guard let city = users.last else { return  }
                cityName = city.name!
                users.removeAll()
                users.append(city)
                dbManager.saveCity(city: users)
              } catch {
                print(error.localizedDescription)
              }
        }
    }
    
}
