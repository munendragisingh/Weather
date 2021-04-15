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
         default: break
            
        }
    }
    
    func openSearchView() {
        guard let searchViewController = self.storyboard?.instantiateViewController(identifier: "SearchViewController") else { return  }
        self.navigationController?.present(searchViewController, animated: true, completion: nil)
    }
    
}

