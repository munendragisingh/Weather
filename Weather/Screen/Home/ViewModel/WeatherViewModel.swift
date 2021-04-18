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
    
    var isDataAvailable: Bool {
        return responseData != nil
    }
    
    
    /// getCityWeather takes city id. using weather api it will get weather data of a perticular city and return it to caller
    /// - Parameters:
    ///   - cityid: id of city
    ///   - complition:Complition with weather data or error
    func getCityWeather(cityid: String, complition: @escaping Complition){
        let urlString = urlManager.weatherCity(cityID: cityid)
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
    
    func weatherData() -> WeatherData? {
        return responseData
    }
    
    func cityTemp() -> String {
        guard let data = responseData, let main = data.main, let temp = main.temp else {
            return "0"
        }
        
        return String(format: "%.2f", (temp - 273.15))
    }
    
    func cityHighTemp() -> String {
        guard let data = responseData, let main = data.main, let temp = main.tempMax else {
            return "0"
        }
        
        return String(format: "%.2f", (temp - 273.15))
    }
    
    func cityLowTemp() -> String {
        guard let data = responseData, let main = data.main, let temp = main.tempMin else {
            return "0"
        }
        
        return String(format: "%.2f°", (temp - 273.15))
    }
    
    func getImage() -> String {
        return urlManager.imageURL(image: "\(responseData?.weather?.first?.icon ?? "")@2x.png")
    }
}
