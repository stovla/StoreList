//
//  DetailsVC.swift
//  StoreList
//
//  Created by Vlastimir Radojevic on 8/11/17.
//  Copyright © 2017 Vlastimir Radojevic. All rights reserved.
//

import UIKit
//import GoogleMaps
import MapKit

class DetailsVC: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
   // @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var mapKitView: MKMapView!
    
    @IBOutlet weak var infoPhoneLabel: UILabel!
    @IBOutlet weak var infoEmailLabel: UILabel!
    @IBOutlet weak var infoWebsiteLabel: UILabel!
    @IBOutlet weak var infoLocationLabel: UILabel!
    
    var store: Store?
    
    var image: UIImage?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUi()
        updateMap()
    }
    
    // updating the view 
    func updateUi() {
        
        self.nameLabel.text = store?.name
        self.addressLabel.text = store?.address
        
        self.logoImage.image = store?.image

        self.infoPhoneLabel.text = "(\(String(describing: store?.phone)))"

        self.infoEmailLabel.text = "(info@email.com)"
        self.infoWebsiteLabel.text = "(www.example.com)"
    }

    // map with MKMap
    private func updateMap() {
        
        let latitude: CLLocationDegrees = store?.latitude ?? 0
        let longitude: CLLocationDegrees = store?.longitude ?? 0
        
        let latDelta: CLLocationDegrees = 0.01
        let lonDelta: CLLocationDegrees = 0.01
        
        let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        let center: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        let location: MKCoordinateRegion = MKCoordinateRegion(center: center, span: span)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = center
        annotation.title = store?.name
        
        mapKitView.addAnnotation(annotation)
        mapKitView.setRegion(location, animated: true)
    }
}

