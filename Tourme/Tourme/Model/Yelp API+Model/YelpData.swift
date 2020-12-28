//
//  YelpData.swift
//  Tourme
//
//  Created by Dua Almahyani on 26/12/2020.
//

import Foundation


struct YelpData: Codable {
    let businesses: [Business]
}

struct Business: Codable {
    let name: String
    let image_url: String
    let rating: Float
    let phone: String
    let id: String
    let is_closed: Bool
    let distance: Double
    let url: String
    let coordinates: Coordinate
    let location: Location
}

struct Coordinate: Codable {
    let latitude: Double?
    let longitude: Double?
}

struct Location: Codable {
    let city: String
    let address1: String?
    let state: String
    let zip_code: String
}

struct Categories: Codable {
    let alias: String
    let title: String
}
