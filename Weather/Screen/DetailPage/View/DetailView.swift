//
//  DetailView.swift
//  Weather
//
//  Created by Pratap SIngh on 17/04/21.
//

import UIKit

enum WeatherDetailEvent {
    case GoBack
}

class WeatherDetailView: GradientView {
    let viewModel = WeatherDetailViewModel()
    @IBOutlet weak var temp: UILabel?
    @IBOutlet weak var city: UILabel?
    @IBOutlet weak var detail: UILabel?
    
    func setWeatherData(weatherData: WeatherData?) {
        self.viewModel.setWeatherData(weatherData: weatherData)
        temp?.text = self.viewModel.cityTemp()
        city?.text = self.viewModel.cityName()
        detail?.text = self.viewModel.weatherDescription()
    }
    
    @IBAction func goBack(sender: UIButton){
        self.delegate?.view(view: self, didPerformAction: WeatherDetailEvent.GoBack, userInfo: nil)
    }
}
