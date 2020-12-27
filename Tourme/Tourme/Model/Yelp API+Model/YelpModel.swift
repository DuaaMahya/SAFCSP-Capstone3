//
//  YelpModel.swift
//  Tourme
//
//  Created by Dua Almahyani on 26/12/2020.
//

import Foundation

struct YelpModel {
    var businessID: String?
    var businessName: String?
    var businessPhoto: String?
    var businessURL: String?
    var businessRating: Float?
    var businessCurrntStatus: String?
    var businessLat: Double?
    var businessLong: Double?
    var businessDistance: Double?
    var businessAddress1: String?
    var businessCity: String?
    var businessState: String?
    var businessZip: String?
    
    var businessAddress: String {
        return "\(businessAddress1 ?? ""), \(businessCity ?? ""), \(businessState ?? "") \(businessZip ?? "")"
    }
    
    
    var businessIsOpen: Bool = false {
        didSet {
            if businessIsOpen {
                businessCurrntStatus = "Open"
            } else {
                businessCurrntStatus = "Closed"
            }
        }
    }
}
