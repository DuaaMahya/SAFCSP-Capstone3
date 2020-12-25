//
//  WeatherAPI.swift
//  Tourme
//
//  Created by Dua Almahyani on 25/12/2020.
//

import Foundation

struct WeatherManger {
    let weatherURL = "https://api.weatherapi.com/v1/current.json?key=4a03729482874f59847225041201612"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                
                if error != nil {
                    print(error!)
                    return
                }
                
                if let data = data {
                    let dataString = String(data: data, encoding: .utf8)
                    print(dataString)
                    self.parseJSON(data: data)
                }
                
                
                
                guard let response = response else {
                    print("no response")
                    return
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(data: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: data)
            let code = decodedData.current.condition.code
            let temp = decodedData.current.temp_c
            let name = decodedData.location.name
            
            let weather = WeatherModel(conditionCode: code, cityName: name, temperature: temp)
            
            print(weather.conditionName)
        } catch {
            print(error)
        }
        
    }
    
    
}
