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
        storeAddressLabel.numberOfLines = 0
        storeNameLabel.numberOfLines = 0
        storePhoneLabel.numberOfLines = 0
        
        storeLogoImage.layer.cornerRadius = storeLogoImage.frame.width / 2
        storeLogoImage.layer.borderColor = UIColor.black.cgColor
        storeLogoImage.layer.borderWidth = 1
        
        contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 0).isActive = true
        
        self.heightAnchor.constraint(greaterThanOrEqualToConstant: 0).isActive = true
        
        storeLogoImage.backgroundColor = .lightGray
        storeNameLabel?.text = store?.name
        storeAddressLabel?.text = store?.address
        
        storePhoneLabel?.text = store?.phone
        storeLogoImage?.image = store?.logoImage
    }
    
}
