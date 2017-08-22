//
//  StoreTVC.swift
//  StoreList
//
//  Created by Vlastimir Radojevic on 8/10/17.
//  Copyright © 2017 Vlastimir Radojevic. All rights reserved.
//

import UIKit

class StoreTVCell: UITableViewCell {

    @IBOutlet weak var storeNameLabel: UILabel!
    @IBOutlet weak var storeAddressLabel: UILabel!
    @IBOutlet weak var storePhoneLabel: UILabel!
    @IBOutlet weak var storeLogoImage: UIImageView!

    var store: Store? {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        storeNameLabel?.text = store?.name
        storeAddressLabel?.text = store?.address
        storePhoneLabel?.text = store?.phone
        storeLogoImage?.image = store?.image
    }
    
}
