//
//  WeatherHomeView.swift
//  Weather
//
//  Created by Pratap SIngh on 14/04/21.
//

import UIKit

enum HomeEvent {
    case Search
    case SelectRow
}

class WeatherHomeView: GradientView {
    var viewModel = HomeViewModel()
//    var weatherViewModel: Array<WeatherViewModel> = []
    @IBOutlet weak var tableView: UITableView?

    override func viewDidLoad() {
        tableView?.reloadData()
    }
    
    /// search city
    /// - Parameter sender: button object
    @IBAction func searchCity(sender: UIButton){
        self.delegate?.view(view: self, didPerformAction: HomeEvent.Search, userInfo: nil)
    }
    
    /// add city fto view fom cell
    /// - Parameter city: city
    func reloadView(city: City?) {
        viewModel.addCity(city: city)
        tableView?.reloadData()
    }
}


extension WeatherHomeView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.removeCity(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        guard let cell = tableView.cellForRow(at: indexPath) as? CityWeatherCell, let weatherData = cell.getWeatherData() else { return }
        self.delegate?.view(view: self, didPerformAction: HomeEvent.SelectRow, userInfo: weatherData)
    }
}

extension WeatherHomeView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CityWeatherCell", for: indexPath) as? CityWeatherCell else { return CityWeatherCell() }
        cell.selectionStyle = .none
        cell.setViewModel(viewModel: viewModel.cityViewModel(index: indexPath.row))
        return cell
    }
}
