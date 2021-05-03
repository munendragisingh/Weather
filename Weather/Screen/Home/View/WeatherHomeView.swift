//
//  WeatherHomeView.swift
//  Weather
//
//  Created by Pratap SIngh on 14/04/21.
//

import UIKit
//import Realm
import RealmSwift

enum HomeEvent {
    case Search
    case SelectRow
    case noInternat
    
}

class WeatherHomeView: GradientView {
    var viewModel = HomeViewModel()
    let dbManager = DBManager()
    @IBOutlet weak var tableView: UITableView?
    fileprivate var loaderView = UIView()

    lazy var refreshControl: UIRefreshControl = {
            let refreshControl = UIRefreshControl()
            refreshControl.addTarget(self, action:
                         #selector(WeatherHomeView.handleRefresh(_:)),
                                     for: UIControl.Event.valueChanged)
            refreshControl.tintColor = UIColor.gray
            
            return refreshControl
        }()
    
    override func viewDidLoad() {
        if(!dbManager.isCityInLocal()){
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                self?.saveCityJSONToDB()
            }
        }
        self.tableView?.addSubview(self.refreshControl)
        tableView?.reloadData()
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        if Utility.main.isConnected {
            viewModel.loadData()
            tableView?.reloadData()
        }else{
           print("No internet")
            self.delegate?.view(view: self, didPerformAction: HomeEvent.noInternat, userInfo: nil)
        }
        refreshControl.endRefreshing()
    }
    
    override func layoutSubviews() {
        loaderView = LoaderView(frame: Utility.main.window?.frame ?? self.frame)
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
    
    private func saveCityJSONToDB(){
        self.showLoader()
        if let path = Bundle.main.path(forResource: "city_list", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                guard let users = try? JSONDecoder().decode(List<City>.self, from: data) else {
                    return
                }
                dbManager.saveCity(city: users)
                dbManager.setDefaultCity()
                self.hideLoader()
                DispatchQueue.main.async { [weak self] in
                    self?.viewModel.loadData()
                    self?.tableView?.reloadData()
                }
              } catch {
                print(error.localizedDescription)
                self.hideLoader()
              }
        }
        self.hideLoader()
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

extension WeatherHomeView{
/// display full screen loader
 func showLoader() {
    DispatchQueue.main.async { [weak self] in
        guard let `self` = self else{
            return
        }
        Utility.main.window?.addSubview(self.loaderView)
    }
}

/// remove full screen loader
func hideLoader() {
    DispatchQueue.main.async { [weak self] in
        guard let `self` = self else {
            return
        }
        self.loaderView.removeFromSuperview()
    }
}
}
