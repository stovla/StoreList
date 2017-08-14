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
            fetchImages()
        }
    }
    
    
    var newImage: UIImage? {
        didSet {
            updateUI()
        }
    }
    
    // updating images
    func fetchImages() {
        
        guard let url = URL(string: (store?.logoURL)!) else { return }            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                
            if error != nil {
                print("Failed fetching image: \(String(describing: error))")
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("Not a proper HTTPURLResponse or statusCode")
                return
            }
            if let imageData = data {
                DispatchQueue.main.sync {
                    self.newImage = UIImage(data: imageData)
                }
            }
            
        }.resume()
        
        
    }
    
    private func updateUI() {
        storeNameLabel?.text = store?.name
        storeAddressLabel?.text = store?.address
        storePhoneLabel?.text = store?.phone
        storeLogoImage?.image = newImage
    }
    
}
