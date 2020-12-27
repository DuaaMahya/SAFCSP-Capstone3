//
//  YelpManger.swift
//  Tourme
//
//  Created by Dua Almahyani on 26/12/2020.
//

import Foundation

protocol YelpDelegate {
    func didUpdateBusiness(_ yelpManger: YelpManger, business: [Business])
}

struct YelpEndPoint {
    
    static let yelpBaseURL: String = "https://api.yelp.com/v3/businesses/search?"
    
    static let apiKey: String = "VK6PDghKR1qvNnAHKNFpmF6qsyV2S0-62xBpumyw4t2d4AMKdc0KbOZgKGQh9FA554YsyFHCoFOmMKgYaxvNjBCqP7gBRuTY4DFzWS-naoKDFpi3TJungA-b_J_mX3Yx"
    
    static func fillLatAndLongURL(lat: Double, long: Double, categories: String? = nil) -> String {
        return yelpBaseURL + "latitude=\(lat)&longitude=\(long)\(categories ?? "")&sort_by=distance"
    }
    
    static func fillCityURL(city: String) -> String {
        return yelpBaseURL + "location=\(city)&sort_by=distance"
    }
    
}

class YelpManger {
    
    var delegate: YelpDelegate?
    
    
    func fetchYelp(lat: Double? = nil, long: Double? = nil, city: String? = nil,
                      completion: @escaping (Result<[Business], Error>) -> Void) {
        
        var urlString = String()
        
        if lat != nil, long != nil {
            urlString = YelpEndPoint.fillLatAndLongURL(lat: lat!, long: long!)
        }
        
        if city != nil {
            urlString = YelpEndPoint.fillCityURL(city: city!)
        }
        
        if let url = URL(string: urlString) {
            
            var request = URLRequest(url: url)
            request.setValue("Bearer \(YelpEndPoint.apiKey)", forHTTPHeaderField: "Authorization")
            request.httpMethod = "GET"
            
            print("\n \n \n\n\n\n\n\n\n\n\n\n\n\n\n\nrequest: \(request)")
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: request) { (data, response, error) in
                
                if error != nil {
                    print(error!)
                    return
                }
                
                guard let data = data  else {
                    print("Empty data")
                    return
                }
                
                if let yelp = self.parseJSON(data: data) {
                    self.delegate?.didUpdateBusiness(self, business: yelp)
                }
                
                print(data)
                
                
                guard let response = response as? HTTPURLResponse else {
                    // Handle Empty Response
                    print("Empty Response")
                    return
                }
                print("Yelp response status code: \(response.statusCode)")
                
                self.handler(data: data, response: response, error: error) { (result) in
                    completion(result)
                }
            }
            task.resume()
        }
    }
    
//    func parseJSON(data: Data) -> YelpModel? {
//        //let decoder = JSONDecoder()
//        var businessList = [YelpModel]()
//        do {
//            let json = try JSONSerialization.jsonObject(with: data, options: [])
//
//            guard let resp = json as? NSDictionary else { return nil }
//
//            guard let businesses = resp.value(forKey: "businesses") as? [NSDictionary] else { return nil }
//
//            //let businesses = try decoder.decode(YelpData.self, from: data)
//
//            for business in businesses {
//                var yelp = YelpModel()
//                yelp.businessName = business.value(forKey: "name") as? String
//                yelp.businessID = business.value(forKey: "id") as? String
//                yelp.businessPhoto = business.value(forKey: "image_url") as? String
//                yelp.businessURL = business.value(forKey: "url") as? String
//                yelp.businessRating = business.value(forKey: "rating") as? Float
//                yelp.businessDistance = business.value(forKey: "distance") as? Double
//                yelp.businessAddress1 = business.value(forKey: "location.address1") as? String
//                yelp.businessCity = business.value(forKey: "location.city") as? String
//                yelp.businessState = business.value(forKey: "state") as? String
//                yelp.businessZip = business.value(forKey: "zip_code") as? String
//
//                businessList.append(yelp)
//            }
//
//
//        } catch {
//            print(error)
//            return nil
//        }
//
//    }
    
    func parseJSON(data: Data) -> [Business]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(YelpData.self, from: data)
            return decodedData.businesses
            
        } catch {
            print(error)
            return nil
        }
        
    }
    
    func handler(data: Data?, response: URLResponse?, error: Swift.Error?,completion: @escaping (Result<[Business], Error>) -> Void) {
        guard let data = data, let httpResponse = response as? HTTPURLResponse else { return }
        
        print("Received \(data.count) bytes with status code \(httpResponse.statusCode).")
        
        
        if httpResponse.statusCode == 200 {
            do {
                let decoder = JSONDecoder()
                let yelpResponse = try decoder.decode(YelpData.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(yelpResponse.businesses))
                    
                }
                
            }catch let error{
                completion(.failure(error))
            }
        }
        
    }
}
