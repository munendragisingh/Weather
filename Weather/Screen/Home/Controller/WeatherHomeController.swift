//
//  ViewController.swift
//  Weather
//
//  Created by Pratap SIngh on 14/04/21.
//

import UIKit

class WeatherHomeController: ViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func view(view: View, didPerformAction action: Any, userInfo: Any?) {
        switch action {
        case HomeEvent.Search:
            openSearchView()
        case HomeEvent.SelectRow:
            openDetailPage(userInfo: userInfo)
         default: break
            
        }
    }
    
    func openDetailPage(userInfo: Any?) {
        guard let userInfo = userInfo, let data = userInfo as? WeatherData else { return }
        guard let detailController = self.storyboard?.instantiateViewController(identifier: "WeatherDetailController") as? WeatherDetailController else { return }
        detailController.weatherData = data
        self.navigationController?.pushViewController(detailController, animated: true)
    }
    
    func openSearchView() {
        guard let searchViewController = self.storyboard?.instantiateViewController(identifier: "SearchViewController") else { return  }
        self.navigationController?.present(searchViewController, animated: true, completion: nil)
    }
    
}

