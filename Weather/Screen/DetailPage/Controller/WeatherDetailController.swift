//
//  DetailViewController.swift
//  Weather
//
//  Created by Pratap SIngh on 17/04/21.
//

import UIKit

class WeatherDetailController: ViewController {
    var weatherData: WeatherData?
    override func viewDidLoad() {
        super.viewDidLoad()
        setWeatherData()
    }
    
    override func view(view: View, didPerformAction action: Any, userInfo: Any?) {
        switch action {
        case WeatherDetailEvent.GoBack:
            self.navigationController?.popViewController(animated: true)
         default: break
            
        }
    }
    
    func setWeatherData() {
        (self.view as? WeatherDetailView)?.setWeatherData(weatherData: weatherData)
    }
    
}
