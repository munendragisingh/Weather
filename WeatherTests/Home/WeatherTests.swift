//
//  WeatherTests.swift
//  WeatherTests
//
//  Created by Pratap SIngh on 14/04/21.
//

import XCTest
@testable import Weather

class WeatherTests: XCTestCase {
    let viewModel = WeatherViewModel()
    override func setUpWithError() throws {
        
    }
    
    func testgetCityWeather() throws {
        
        let urlManager = URLManager()
        let url1 = URL(string: urlManager.weatherCity(cityID: "4163971"))
        URLProtocolMock.testURLs = [url1: "weatherData"]
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        let session = URLSession(configuration: config)
        NetworkManager.main.setMockSession(session: session)
        
        let expectation = self.expectation(description: "Success Test")
        viewModel.getCityWeather(cityid: "4163971") { (data, error) in
            XCTAssertNotNil(data, "data should not be nil")
            XCTAssertNil(error, "error should be nil")
            XCTAssertEqual(data?.name, "Sydney","city name should be 'Sydney'")
            
            let weatherData = self.viewModel.weatherData()
            XCTAssertNotNil(weatherData, "weatherData should not be nil")
            
            let cityTemp = self.viewModel.cityTemp()
            XCTAssertEqual(cityTemp, "18.96", "cityTemp should '18.96'")
            
            let cityHighTemp = self.viewModel.cityHighTemp()
            XCTAssertEqual(cityHighTemp, "20.00", "cityHighTemp should '18.96'")
            
            let cityLowTemp = self.viewModel.cityLowTemp()
            XCTAssertEqual(cityLowTemp, "17.78°", "cityHighTemp should '17.78°'")
            
            let getImage = self.viewModel.getImage()
            XCTAssertGreaterThan(getImage.count, 0, "getImage() must return url")
            
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
    }
    
    func testgetCityWeatherNoData() throws {
        
        let urlManager = URLManager()
        let url1 = URL(string: urlManager.weatherCity(cityID: "4163971"))
        URLProtocolMock.testURLs = [url1: "weatherNoData"]
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        let session = URLSession(configuration: config)
        NetworkManager.main.setMockSession(session: session)
        
        let expectation = self.expectation(description: "Success Test")
        viewModel.getCityWeather(cityid: "4163971") { (data, error) in
            XCTAssertNotNil(error, "error should not be nil")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
    }
    
    func testgetCityWeatherError() throws {
        let urlManager = URLManager()
        let url = URL(string: urlManager.weatherCity(cityID: "4163971"))
        
        URLProtocolMock.httpError = NSError(domain: url?.path ?? "", code: 400, userInfo: ["localizedDescription":"Internal server error"])
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        let session = URLSession(configuration: config)
        NetworkManager.main.setMockSession(session: session)
        
        let expectation = self.expectation(description: "Success Test")
        viewModel.getCityWeather(cityid: "4163971") { (data, error) in
            XCTAssertNotNil(error, "error should not be nil")
            XCTAssertNil(data, "data should be nil")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
    }

}
