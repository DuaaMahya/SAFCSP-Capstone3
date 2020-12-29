//
//  YelpData.swift
//  Tourme
//
//  Created by Dua Almahyani on 26/12/2020.
//

import Foundation
import RealmSwift

class YelpData: Object, Codable {
    @objc dynamic var businesses: [Business]
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
    dynamic var coordinates: Coordinate
    dynamic var location: Location
}

@objcMembers class Coordinate: Object, Codable {
    dynamic var latitude: Double?
    dynamic var longitude: Double?
}

@objcMembers class Location: Object, Codable {
    dynamic var city: String
    dynamic var address1: String?
    dynamic var state: String
    dynamic var zip_code: String
}

struct Categories: Codable {
    let alias: String
    let title: String
}
