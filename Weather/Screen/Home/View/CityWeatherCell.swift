//
//  CityWeatherCell.swift
//  Weather
//
//  Created by Pratap SIngh on 15/04/21.
//

import UIKit

class CityWeatherCell: UITableViewCell {
    @IBOutlet weak var cityLabel: UILabel?
    @IBOutlet weak var temp: UILabel?
    @IBOutlet weak var hum: UILabel?
    
    private let weatherViewModel = WeatherViewModel()
    
    override func prepareForReuse() {
        cityLabel?.text = ""
        temp?.text = ""
        temp?.text = ""
    }
    
    func setData(city: City) {
        cityLabel?.text = city.name
        let cityid = city.id
        let ass = String(format: "%d", cityid)
        weatherViewModel.getCityWeather(cityid: ass) {[weak self] (data, error) in
            DispatchQueue.main.async {
                self?.setWeatherData()
            }
        }
    }
    
    func setWeatherData() {
        temp?.text = weatherViewModel.cityTemp()
        hum?.text = "H:\(weatherViewModel.cityHighTemp()) L:\(weatherViewModel.cityLowTemp())"
    }
    
}
