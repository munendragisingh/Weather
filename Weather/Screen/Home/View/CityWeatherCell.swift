//
//  CityWeatherCell.swift
//  Weather
//
//  Created by Pratap SIngh on 15/04/21.
//

import UIKit

class CityWeatherCell: UITableViewCell {
    @IBOutlet weak var cityLabel: UILabel?
    @IBOutlet weak var temp: LoadingLabel?
    @IBOutlet weak var hum: LoadingLabel?
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
        temp?.startLoading()
        hum?.startLoading()
        if viewModel.isDataAvailable {
            self.setWeatherData()
        } else if Utility.main.isConnected {
            viewModel.getCityWeather() {[weak self] (data, error) in
                DispatchQueue.main.async {
                    self?.setWeatherData()
                }
             }
        }
    }
    
    /// set weather data in in cell
    func setWeatherData() {
        temp?.stopLoading()
        hum?.stopLoading()
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
