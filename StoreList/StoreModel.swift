//
//  StoreModel.swift
//  StoreList
//
//  Created by Vlastimir Radojevic on 8/10/17.
//  Copyright © 2017 Vlastimir Radojevic. All rights reserved.
//

import Foundation
import UIKit

public struct Store {
    
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
    
    let image: UIImage?

}

// printable form, NEEDS TO BE UPDATED
extension Store: CustomStringConvertible {
    public var description: String {
        return "\(String(describing: name))"
    }
}
