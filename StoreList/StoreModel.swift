//
//  StoreModel.swift
//  StoreList
//
//  Created by Vlastimir Radojevic on 8/10/17.
//  Copyright © 2017 Vlastimir Radojevic. All rights reserved.
//

import Foundation

public class Store {
    
     //store model 
    var address: String
    var city: String
    var name: String
    var latitude: String
    var longitude: String
    var logoURL: String
    var zipCode: String
    var phone: String
    var storeID: String
    var state: String
    
    
    // if it is used as URL directly
    // var logoURL: URL?
    
    
    init(dictionary: [String: Any]) {
        
        name = dictionary["name"] as? String ?? ""
        address = dictionary["address"] as? String ?? ""
        city = dictionary["city"] as? String ?? ""
        
        latitude = dictionary["latitude"] as? String ?? ""
        longitude = dictionary["longitude"] as? String ?? ""
        
        zipCode = dictionary["zipcode"] as? String ?? ""
        phone = dictionary["phone"] as? String ?? ""
        storeID = dictionary["storeID"] as? String ?? ""
        state = dictionary["state"] as? String ?? ""
        logoURL = dictionary["storeLogoURL"] as? String ?? ""
        
        // used directly as a URL
//        if let urlString = dictionary["storeLogoURL"] as? String {
//            logoURL = URL(string:urlString)
//        }
    }
}

// printable form, NEEDS TO BE UPDATED
extension Store: CustomStringConvertible {
    public var description: String {
        return "\(name)"
    }
}
