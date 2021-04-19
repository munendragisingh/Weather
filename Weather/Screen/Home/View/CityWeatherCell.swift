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
    @IBOutlet weak var weatherImage: ImageLoader?
    private var viewModel: WeatherViewModel?
    
    /// prepare for reuse
    override func prepareForReuse() {
        cityLabel?.text = ""
        temp?.text = ""
        temp?.text = ""
    }
    
    /// set view model to cell
    /// - Parameter viewModel: view model
    func setViewModel(viewModel: WeatherViewModel) {
        self.viewModel = viewModel
        cityLabel?.text = self.viewModel?.cityName
        temp?.text = "..."
        hum?.text = "H:... L:..."
        if viewModel.isDataAvailable {
            self.setWeatherData()
        } else {
            viewModel.getCityWeather() {[weak self] (data, error) in
                DispatchQueue.main.async {
                    self?.setWeatherData()
                }
             }
        }
    }
    
    /// set weather data in in cell
    func setWeatherData() {
        temp?.text = viewModel?.cityTemp()
        let high = String(describing: viewModel?.cityHighTemp() ?? "")
        let low = String(describing: viewModel?.cityLowTemp() ?? "")
        hum?.text = "H:\(high) L:\(low)"
        if let imgUrl = URL(string: viewModel?.getImage() ?? "") {
            weatherImage?.loadImageWithUrl(url: imgUrl,placeHolderImage: UIImage(named: "placeHolder"))
        }
    }
    
    /// return cell weather data
    /// - Returns: weather data
    func getWeatherData() -> WeatherData? {
        return viewModel?.weatherData()
    }
    
}
