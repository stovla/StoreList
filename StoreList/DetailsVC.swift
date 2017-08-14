//
//  DetailsVC.swift
//  StoreList
//
//  Created by Vlastimir Radojevic on 8/11/17.
//  Copyright © 2017 Vlastimir Radojevic. All rights reserved.
//

import UIKit
import GoogleMaps
//import MapKit

class DetailsVC: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var mapView: GMSMapView!
    
    @IBOutlet weak var infoPhoneLabel: UILabel!
    @IBOutlet weak var infoEmailLabel: UILabel!
    @IBOutlet weak var infoWebsiteLabel: UILabel!
    @IBOutlet weak var infoLocationLabel: UILabel!
    
    var store: Store? {
        didSet {
            // test if the store object got set
            print("set : \(String(describing: store?.name))")
        }
    }
    
    var image: UIImage?

    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUi()
        updateMap()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    private func updateUi() {
        self.nameLabel.text = store?.name
        self.addressLabel.text = store?.address
        
        // using private description
        // self.descriptionLabel.text = store?.description
        self.logoImage.image = self.image

        self.infoPhoneLabel.text = "(\((store?.phone)!))"

        self.infoEmailLabel.text = "(info@email.com)"
        self.infoWebsiteLabel.text = "(www.example.com)"
    }
    
    private func updateMap() {
        
        // Create a GMSCameraPosition that tells the map to display
        let latitude: CLLocationDegrees = CLLocationDegrees((store?.latitude)!)!
        let longitude: CLLocationDegrees = CLLocationDegrees((store?.longitude)!)!
        
        
        let location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)

        mapView.animate(toLocation: location)
        mapView.animate(with: GMSCameraUpdate.setTarget(location, zoom: 12.0))
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        
        marker.position = location
        marker.map = mapView

    }
    
    // map with MKMap
//    private func updateMap() {
//        
//        let latitude: CLLocationDegrees = Double((store?.latitude)!)!
//        let longitude: CLLocationDegrees = Double((store?.longitude)!)!
//        
//        let latDelta: CLLocationDegrees = 0.01
//        let lonDelta: CLLocationDegrees = 0.01
//        
//        let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
//        let center: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
//        
//        let location: MKCoordinateRegion = MKCoordinateRegion(center: center, span: span)
//        
//        let annotation = MKPointAnnotation()
//        annotation.coordinate = center
//        annotation.title = store?.name
//        
//        mkMap.addAnnotation(annotation)
//        mkMap.setRegion(location, animated: true)
//    }

}
