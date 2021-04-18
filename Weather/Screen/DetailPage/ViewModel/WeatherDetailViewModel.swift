//
//  DetailViewModel.swift
//  Weather
//
//  Created by Pratap SIngh on 17/04/21.
//

import Foundation

class WeatherDetailViewModel {
    private var weatherData: WeatherData?
    
    func setWeatherData(weatherData: WeatherData?) {
        self.weatherData = weatherData
    }
    
    func cityTemp() -> String {
        guard let data = weatherData, let main = data.main, let temp = main.temp else {
            return "0"
        }
        
        return String(format: "%.1f°", (temp - 273.15))
    }
    
    func cityName() -> String {
        guard let data = weatherData, let name = data.name else {
            return ""
        }
        
        return name
    }
    
    func weatherDescription() -> String {
        guard let data = weatherData, let weatherDescription = data.weather?.last?.weatherDescription else {
            return ""
        }
        
        return weatherDescription
    }
}
