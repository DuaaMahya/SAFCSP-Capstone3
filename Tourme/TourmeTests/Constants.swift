//
//  Constants.swift
//  Tourme
//
//  Created by Dua Almahyani on 30/12/2020.
//

import Foundation

enum Constants {
    static let urlString = "https://api.yelp.com/v3/businesses/search?latitude=37.773972&longitude=-122.431297&sort_by=distance"
    
    static let id = "HgJ6kIFKKEX93VWukoiRTg"
    static let name = "The Tea House of the Sacred Heart"
    
    static let url = URL(string: urlString)!
    
    
    static let validBusinessDict: [String:Any] = [
        "id": id,
        "name": name,
        "image_url": "8db37aca25",
        "rating": "65535",
        "phone": 66,
        "is_closed": false,
        "distance": 1,
        "url": 0,
        "coordinates": validBusinessCoordinatesDict,
        "location": validBusinessLocationDict
    ]
    
    static let validBusinessCoordinatesDict: [String:Any] = [
        "latitude": 37.7744762599468,
        "longitude": -122.43085809052
    ]
    
    static let validBusinessLocationDict: [String:Any] = [
        "city": "San Francisco",
        "adderss1": "548 Fillmore St",
        "state": "CA",
        "zip_code": 94117
    ]
    
    static let invalidBusinessDict: [String:Any] = [
        "id": "",
        "name": "",
        "image_url": "",
        "rating": "",
        "phone": 66,
        "is_closed": false,
        "distance": 0,
        "url": 0,
        "coordinates": "",
        "location": ""
    ]


    
    static let validBusinessDictionary = ["photo": [validBusinessDict] ]
    static let validBusinessesDictionary = ["photos": validBusinessDictionary]
    
    static let invalidBusinessDictionary = ["photo": [invalidBusinessDict] ]
    static let invalidBusinessesDictionary = ["photos": invalidBusinessDictionary]
    
    static let okResponse = HTTPURLResponse(url: url,
                                            statusCode: 200,
                                            httpVersion: nil,
                                            headerFields: nil)!
    
    static let notOkResponse = HTTPURLResponse(url: url,
                                            statusCode: 404,
                                            httpVersion: nil,
                                            headerFields: nil)!
    
    static let jsonData = try! JSONSerialization.data(withJSONObject: validBusinessesDictionary)
    static let invalidJsonData = try! JSONSerialization.data(withJSONObject: invalidBusinessesDictionary)
    
    static let sessionConfiguration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [FakeScheduleURLProtocol.self]
        return config
    }()
    
}
    
