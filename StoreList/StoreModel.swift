//
//  StoreModel.swift
//  StoreList
//
//  Created by Vlastimir Radojevic on 8/10/17.
//  Copyright © 2017 Vlastimir Radojevic. All rights reserved.
//

import Foundation
import UIKit

struct StoreResponse: Codable {
    let stores: [Store]
}

struct Store: Codable {
    
     //store model 
    let address: String
    let city: String
    let name: String
    let latitude: Double
    let longitude: Double
    let logoURL: String
    let zipCode: String
    let phone: String
    let storeID: String
    let state: String
    
    var logoImage: UIImage {
        if let url = URL(string: logoURL),
           let data = try? Data(contentsOf: url) {
            return UIImage(data: data) ?? UIImage()
        } else {
            return UIImage()
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case address
        case city
        case name
        case latitude
        case longitude
        case logoURL = "storeLogoURL"
        case zipCode = "zipcode"
        case phone
        case storeID
        case state
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        address = try values.decode(String.self, forKey: .address)
        city = try values.decode(String.self, forKey: .city)
        name = try values.decode(String.self, forKey: .name)
        latitude = try Double(values.decode(String.self, forKey: .latitude)) ?? 0.0
        longitude = try Double(values.decode(String.self, forKey: .longitude)) ?? 0.0
        logoURL = try values.decode(String.self, forKey: .logoURL)
        zipCode = try values.decode(String.self, forKey: .zipCode)
        phone = try values.decode(String.self, forKey: .phone)
        storeID = try values.decode(String.self, forKey: .storeID)
        state = try values.decode(String.self, forKey: .state)
    }
}

// printable form, NEEDS TO BE UPDATED
extension Store: CustomStringConvertible {
    public var description: String {
        return "\(String(describing: name))"
    }
}
