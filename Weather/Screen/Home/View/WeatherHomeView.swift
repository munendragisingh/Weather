//
//  WeatherHomeView.swift
//  Weather
//
//  Created by Pratap SIngh on 14/04/21.
//

import UIKit

enum HomeEvent {
    case Search
}

class WeatherHomeView: GradientView {
    var viewModel: HomeViewModel?
    var cities:Array<City> = []
    @IBOutlet weak var tableView: UITableView?

    override func viewDidLoad() {
        viewModel = HomeViewModel()
        cities = viewModel?.getSelectedCity ?? []
        tableView?.reloadData()
    }
    
    @IBAction func searchCity(sender: UIButton){
        self.delegate?.view(view: self, didPerformAction: HomeEvent.Search, userInfo: nil)
    }
}


extension WeatherHomeView: UITableViewDelegate {
    
}

extension WeatherHomeView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRowsInSection ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CityWeatherCell", for: indexPath) as? CityWeatherCell else { return CityWeatherCell() }
        cell.setData(city: cities[indexPath.row])
        return cell
    }
}
