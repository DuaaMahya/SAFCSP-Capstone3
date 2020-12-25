//
//  WeatherAPI.swift
//  Tourme
//
//  Created by Dua Almahyani on 25/12/2020.
//

import Foundation

protocol WeatherDelegate {
    func didUpdateWeather(_ weatherManger: WeatherManger, weather: WeatherModel)
}

struct EndPoint {
    
    static let weatherBaseURL: String = "https://api.weatherapi.com/v1/current.json?key="
    
    static let apiKey: String = "4a03729482874f59847225041201612"
    
    static func fillURL(lat: Double, long: Double) -> String {
        return weatherBaseURL + apiKey + "&q=\(lat),\(long)"
    }
    
}

struct WeatherManger {
    
    var delegate: WeatherDelegate?
    
    func fetchWeather(lat: Double, long: Double, completion: @escaping (Result<WeatherData, Error>) -> Void) {
        let urlString = EndPoint.fillURL(lat: lat, long: long)
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                
                if error != nil {
                    print(error!)
                    return
                }
                
                if let data = data {
                    if let weather = self.parseJSON(data: data) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
                
                
                
                guard let response = response as? HTTPURLResponse else {
                    // Handle Empty Response
                    print("Empty Response")
                    return
                }
                print("Response status code: \(response.statusCode)")
                
                self.handler(data: data, response: response, error: error) { (result) in
                    completion(result)
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(data: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: data)
            let code = decodedData.current.condition.code
            let temp = decodedData.current.temp_c
            let name = decodedData.location.name
            
            let weather = WeatherModel(conditionCode: code, cityName: name, temperature: temp)
            return weather
            
        } catch {
            print(error)
            return nil
        }
        
    }
    
    func handler(data: Data?, response: URLResponse?, error: Swift.Error?,completion: @escaping (Result<WeatherData, Error>) -> Void) {
        guard let data = data, let httpResponse = response as? HTTPURLResponse else { return }
        
        print("Received \(data.count) bytes with status code \(httpResponse.statusCode).")
        
        
        if httpResponse.statusCode == 200 {
            do {
                let decoder = JSONDecoder()
                let weatherResponse = try decoder.decode(WeatherData.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(weatherResponse))
                    
                }
                
            }catch let error{
                completion(.failure(error))
            }
        }
        
    }
    
}
