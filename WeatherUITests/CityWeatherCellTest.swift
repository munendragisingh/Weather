//
//  CityWeatherCellTest.swift
//  WeatherUITests
//
//  Created by Pratap SIngh on 23/04/21.
//

import XCTest
import UIKit
@testable import Weather

class CityWeatherCellTest: XCTestCase {
    var tableView: UITableView!
//    private var dataSource: TableViewDataSource!
    
    override func setUpWithError() throws {
    
        
//        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 300, height: 400), style: .plain)
//        tableView.register(CityWeatherCell.self, forCellReuseIdentifier: "CityWeatherCell")
//
//        dataSource = TableViewDataSource()
//        tableView.dataSource = dataSource
    }
    
    func testAwakeFromNib() {
//        let indexPath = IndexPath(row: 0, section: 0)
//        let cell = createCell(indexPath: indexPath)
//        cell.configureCell(weatherViewModel)
//        XCTAssertNotNil(cell, "WeatherInformationTableViewCell should not be nil")
//        XCTAssertNotNil(cell.cityNameLabel, "cityNameLabel should not be nil")
//        XCTAssertNotNil(cell.refreshButton, "refreshButton should not be nil")
//        XCTAssertEqual(cell.cityNameLabel.text, "Jodhpur", "City Label text should be Jodhpur")
    }
}

//extension CityWeatherCellTest {
    
//    func createCell(indexPath: IndexPath) -> CityWeatherCell {
//
//        let cell = dataSource.tableView(tableView, cellForRowAt: indexPath) as! CityWeatherCell
//        XCTAssertNotNil(cell)
//
//        let view = cell.contentView
//        XCTAssertNotNil(view)
//
//        return cell
//    }
//}


//private class TableViewDataSource: NSObject, UITableViewDataSource {
//    var items = [AnyObject]()
//
//    override init() {
//        super.init()
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }

//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "CityWeatherCell", for: indexPath)
//        cell.selectionStyle = .none
//        cell.setViewModel(viewModel: items[indexPath.row])
//        return cell
//    }
//}
