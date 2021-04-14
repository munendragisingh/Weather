//
//  URLManager.swift
//  Arch
//
//  Created by Pratap SIngh on 14/04/21.
//

import Foundation

class URLManager {
    private let baseURL: String = "https://api.openweathermap.org/data/2.5/weather"
    private let APIkey = "f0c7efac211d2eab40a6509b1125e984"
    
    func weatherCity(city: String, countryCode: String = "") -> String {
        let countryCode = countryCode.count > 0 ? ("," + countryCode) : ""
        return baseURL + "?q=" + city + countryCode + "&appid=" + APIkey
    }
    
    func weatherCity(cityID: String) -> String {
        return baseURL + "?id=" + cityID + "&appid=" + APIkey
    }
    
    func weatherCity(lat: Double, lon: Double) -> String {
        return baseURL + "?id=" + String(format: "%f", lat) + "&lon=" + String(format: "%f", lon) + "&appid=" + APIkey
    }
}