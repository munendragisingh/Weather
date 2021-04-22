//
//  URLManager.swift
//  Arch
//
//  Created by Pratap SIngh on 14/04/21.
//

import Foundation

class URLManager {
    private let baseURL: String = "https://api.openweathermap.org/data/2.5/weather"
    private let imageBaseURL: String = "https://openweathermap.org/img/wn/"
    private let APIkey = "f0c7efac211d2eab40a6509b1125e984"
    
    func weatherCity(cityID: String) -> String {
        return baseURL + "?id=" + cityID + "&appid=" + APIkey
    }
    
    func imageURL(image: String) -> String {
        return imageBaseURL + image
    }
}
