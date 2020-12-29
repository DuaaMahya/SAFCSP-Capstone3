//
//  YelpData.swift
//  Tourme
//
//  Created by Dua Almahyani on 26/12/2020.
//

import Foundation
import RealmSwift

@objcMembers class YelpData: Object, Codable {
    dynamic var businesses = List<Business>()
    
    enum CodeKey: String, CodingKey {
        case business
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let business = try container.decode([Business].self, forKey: .businesses)
        businesses.append(objectsIn: business)
        
        super.init()
    }
    
    required override init() {
        super.init()
    }
    
}

@objcMembers class Business: Object, Codable {
     dynamic var name: String = ""
     dynamic var image_url: String = ""
     dynamic var rating: Float = 0.0
     dynamic var phone: String = ""
     dynamic var id: String = ""
     dynamic var is_closed: Bool = false
     dynamic var distance: Double = 0.0
     dynamic var url: String = ""
     dynamic var coordinates: Coordinate? = nil
     dynamic var location: Location? = nil
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    enum CodeKey: String, CodingKey {
        case name
        case image_url
        case rating
        case phone
        case id
        case is_closed
        case distance
        case url
        case coordinates
        case location
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try container.decode(String.self, forKey: .name)
        image_url = try container.decode(String.self, forKey: .image_url)
        rating = try container.decode(Float.self, forKey: .rating)
        phone = try container.decode(String.self, forKey: .name)
        id = try container.decode(String.self, forKey: .id)
        is_closed = try container.decode(Bool.self, forKey: .is_closed)
        distance = try container.decode(Double.self, forKey: .distance)
        url = try container.decode(String.self, forKey: .url)
        coordinates = try container.decode(Coordinate.self, forKey: .coordinates)
        location = try container.decode(Location.self, forKey: .location)
        
        super.init()
    }
    
    required override init() {
        super.init()
    }
}

@objcMembers class Coordinate: Object, Codable {
    dynamic var latitude: Double = 0.0
    dynamic var longitude: Double = 0.0
    
    enum CodeKey: String, CodingKey {
        case latitude
        case longitude
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        latitude = try container.decode(Double.self, forKey: .latitude)
        longitude = try container.decode(Double.self, forKey: .longitude)
        
        super.init()
    }
    
    required override init() {
        super.init()
    }
}

@objcMembers class Location: Object, Codable {
    dynamic var city: String = ""
    dynamic var address1: String? = nil
    dynamic var state: String = ""
    dynamic var zip_code: String = ""
    
    enum CodeKey: String, CodingKey {
        case city
        case address1
        case state
        case zip_code
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        city = try container.decode(String.self, forKey: .city)
        address1 = try container.decode(String.self, forKey: .address1)
        state = try container.decode(String.self, forKey: .state)
        zip_code = try container.decode(String.self, forKey: .zip_code)
        
        super.init()
    }
    
    required override init() {
        super.init()
    }
    
}

struct Categories: Codable {
    let alias: String
    let title: String
}
