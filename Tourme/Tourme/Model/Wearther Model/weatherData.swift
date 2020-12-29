//
//  WeatherAPI.swift
//  Tourme
//
//  Created by Dua Almahyani on 21/12/2020.
//

import Foundation

struct WeatherData: Codable {
    let location: Locations
    let current: Current
}

struct Locations: Codable {
    let name: String
}

struct Current: Codable {
    let temp_c: Double
    let condition: Condition
}

struct Condition: Codable {
    let text: String
    let code: Int
}
