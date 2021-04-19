//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Pratap SIngh on 15/04/21.
//

import Foundation

/// WeatherViewModel is used to handle all weather data, get weather data from api, convert data in visiable form
class WeatherViewModel {
    typealias Complition = (_ weatherData: WeatherData?, _ error: Error?) -> Void
    
    private let urlManager = URLManager()
    private let requestManager = RequestManager()
    private var responseData: WeatherData?
    private var city: City?
    
    init(city: City?) {
        self.city = city
    }
    
    /// check if weather data is set
    var isDataAvailable: Bool {
        return responseData != nil
    }
    
    /// return city name
    var cityName: String {
        guard let city = self.city,let name = city.name else { return "" }
        return name
    }
    
    
    /// getCityWeather takes city id. using weather api it will get weather data of a perticular city and return it to caller
    /// - Parameters:
    ///   - cityid: id of city
    ///   - complition:Complition with weather data or error
    func getCityWeather(complition: @escaping Complition){
        guard let city = self.city else {
            complition(nil, NSError(domain: "", code: 500, userInfo: ["error": "invalid city id"]) as Error)
            return
        }
        let urlString = urlManager.weatherCity(cityID: "\(city.id)")
        if let url = URL(string: urlString) {
            requestManager.get(with: url) { [weak self] (data, error) in
                if error != nil {
                    complition(nil, error)
                } else {
                    guard let data = data else {
                        complition(nil, NSError(domain: "", code: 500, userInfo: ["error": "error found"]) as Error)
                        return
                    }
                    let responseData = self?.modelFromData(data)
                    if  let responseData = responseData {
                        complition(responseData, nil)
                    } else {
                        complition(nil, NSError(domain: "", code: 500, userInfo: ["error": "No Movie found"]) as Error)
                    }
                }
            }
                
        }
    }
    
    ///modelFromData is a private method to convert weather data to WeatherData model
    /// - Parameter data: Data
    /// - Returns: WeatherData model
    private func modelFromData(_ data: Data) -> WeatherData? {
        let decoder = JSONDecoder()
        do {
            responseData = try decoder.decode(WeatherData.self, from: data)
        } catch {
            
        }
        return responseData
    }
    
    /// return Weather data
    /// - Returns: WeatherData
    func weatherData() -> WeatherData? {
        return responseData
    }
    
    /// return city temperature in celsius
    /// - Returns: temperature in celsius
    func cityTemp() -> String {
        guard let data = responseData, let main = data.main, let temp = main.temp else {
            return "0"
        }
        
        return String(format: "%.2f", (temp - 273.15))
    }
    
    /// return city high temperature in celsius
    /// - Returns: temperature in celsius
    func cityHighTemp() -> String {
        guard let data = responseData, let main = data.main, let temp = main.tempMax else {
            return "0"
        }
        
        return String(format: "%.2f", (temp - 273.15))
    }
    
    /// return city low temperature in celsius
    /// - Returns: temperature in celsius
    func cityLowTemp() -> String {
        guard let data = responseData, let main = data.main, let temp = main.tempMin else {
            return "0"
        }
        
        return String(format: "%.2f°", (temp - 273.15))
    }
    
    /// return 2x image url
    /// - Returns: image URL
    func getImage() -> String {
        return urlManager.imageURL(image: "\(responseData?.weather?.first?.icon ?? "")@2x.png")
    }
}
