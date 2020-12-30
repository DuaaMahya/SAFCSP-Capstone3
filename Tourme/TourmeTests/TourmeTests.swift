//
//  TourmeTests.swift
//  TourmeTests
//
//  Created by Dua Almahyani on 21/12/2020.
//

import XCTest
@testable import Tourme

class TourmeTests: XCTestCase {

    var yelpFetcher: YelpManger!
    var weatherFetcher = WeatherManger()
    
    var utility = Utilities()

    override func setUp() {
        super.setUp()
        
        yelpFetcher = YelpManger(configuration: Constants.sessionConfiguration)
    }
    
    func testResultFromYelpFetch() {
        
        yelpFetcher.fetchYelp { (result) in
            switch result {
            case .success(let response):
                XCTAssert(response.businesses.count == 0)
                let theBusiness = response.businesses[1]
                XCTAssertEqual(theBusiness.id, Constants.id)
                XCTAssertEqual(theBusiness.name, Constants.name)
            default:
                XCTFail("Result contains Failure, but Success was expected.")
            }
        }
    }
    
    func testResultFromInvalidHTTPResponseAndInvalidData() {
        yelpFetcher.handler(data: Constants.invalidJsonData,
                        response: Constants.notOkResponse,
                        error: nil) { (result) in
            
            switch result {
            case .failure(let error):
                XCTFail("Result contains Failure\(error.localizedDescription)")
            default:
                break
            }
        }
    }
    
    func testResultFromValidHTTPResponseAndNillData() {
        yelpFetcher.handler(data: nil,
                        response: Constants.okResponse,
                        error: nil) { (result) in
            
            switch result {
            case .failure(let error):
                XCTFail("Result contains Failure\(error.localizedDescription)")
            default:
                break
            }
        }
    }
    
    func testResultFromWeatherFetchNotNil() {
        weatherFetcher.fetchWeather { (result) in
            XCTAssertNotNil(result)
        }
    }
    
    
    func checkStarRatingFunction() {
        let testResult = "★★★☆☆"
        let result = utility.businessStar(numberOfStars: 3)
        XCTAssertEqual(testResult, result, "The strings Matches.")
    }
    
    func checkDistaceFunction() {
        let testResult = "3km"
        let result = utility.distanceCalculator(3000.0)
        XCTAssertEqual(testResult, result, "The Distance Matches.")
    }

}
