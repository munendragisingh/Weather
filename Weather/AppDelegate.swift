//
//  AppDelegate.swift
//  Weather
//
//  Created by Pratap SIngh on 14/04/21.
//

import UIKit
import Realm
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    let dbManager = DBManager()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        if(!dbManager.isCountryInLocal()){
            saveCityJSONToDB()
        }
        dbManager.setDefaultCity()
        
        return true
    }
    
    private func saveCityJSONToDB(){
        if let path = Bundle.main.path(forResource: "city_list", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                guard let users = try? JSONDecoder().decode(List<City>.self, from: data) else {
                    return
                }
                dbManager.saveCountry(city: users)
              } catch {
                print(error.localizedDescription)
              }
        }
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

