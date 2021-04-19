//
//  SearchViewController.swift
//  Weather
//
//  Created by Pratap SIngh on 15/04/21.
//

import UIKit

class SearchViewController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        // Do any additional setup after loading the view.
    }
    
    override func view(view: View, didPerformAction action: Any, userInfo: Any?) {
        switch action {
        case SearchViewEvents.dismis:
            if let navigationController = presentingViewController as? UINavigationController,  let presenter = navigationController.topViewController as? WeatherHomeController,let city = userInfo as? City {
                (presenter.view as? WeatherHomeView)?.reloadView(city: city)
            }
            self.dismiss(animated: true, completion: nil)
         default: break
            
        }
    }

}
