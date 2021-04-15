//
//  WeatherCity.swift
//  Weather
//
//  Created by Pratap SIngh on 14/04/21.
//

import Realm
import RealmSwift

// MARK: - City
class City: Object, Decodable {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String?
    @objc dynamic var state: String?
    @objc dynamic var country: String?
    @objc dynamic var isSlected: Bool = false
    @objc dynamic var coord: Coordinate?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case state
        case country
        case coord
    }
    
    override init() {
        
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        name = try container.decodeIfPresent(String.self, forKey: .name)
        state = try container.decodeIfPresent(String.self, forKey: .state)
        country = try container.decodeIfPresent(String.self, forKey: .country)
        coord = try container.decodeIfPresent(Coordinate.self, forKey: .coord)
        isSlected = false
        print("")
    }
}

// MARK: - Coordinate
class Coordinate: Object, Decodable {
    @objc dynamic var lat: Double = 0.0
    @objc dynamic var lon: Double = 0.0
}

