//
//  WeatherAPI.swift
//  Tourme
//
//  Created by Dua Almahyani on 21/12/2020.
//

import Foundation

struct WeatherModel {
    let conditionCode: Int
    let cityName: String
    let temperature: Double
    
    var temperatureString: String {
        return String(format: "%.0f", temperature)
    }
    
    var conditionName: String {
        switch conditionCode {
        case 1000...1002:
            return "sun"
        case 1003...1030:
            return "cloud"
        case 1063...1065, 1150...1207, 1240...1276:
            return "cloud.rain"
        case 1065...1117, 1210...1237, 1279...1282:
            return "cloud.snow"
        case 1135...1147:
            return "cloud.fog"
        default:
            return "cloud"
        }
    }
    
    
        
}
