//
//  MainTVC.swift
//  StoreList
//
//  Created by Vlastimir Radojevic on 8/10/17.
//  Copyright © 2017 Vlastimir Radojevic. All rights reserved.
//

import UIKit
//import AFNetworking

class MainTVC: UITableViewController {
    
    var refresher = UIRefreshControl(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    
    let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    
    // stores object
    private var stores: [Store] = [] {
        didSet {
            activityIndicator.stopAnimating()
            tableView.reloadData()
        }
    }
    
    @objc private func updateTable() {
        
        let urlString = "http://sandbox.bottlerocketapps.com/BR_Android_CodingExam_2015_Server/stores.json"
        
        guard let url = URL(string: urlString) else { return }
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if error == nil, let usableData = data {
                print(usableData)
                do {
                    // parse STORE objects as dictionaries
                    let json = try JSONSerialization.jsonObject(with: usableData, options: .allowFragments) as? [String: AnyObject]
                    if let parsedJson = json?["stores"] as? [[String: Any]] {
                        print(parsedJson)
                        var tmp: [Store] = []
                        for store in parsedJson {
                            //tmp.append(store)
                            tmp.append(Store(
                                address: store["address"] as? String,
                                city: store["city"] as? String,
                                name: store["name"] as? String,
                                latitude: store["latitude"] as? String,
                                longitude: store["longitude"] as? String,
                                logoURL: store["storeLogoURL"] as? String,
                                zipCode: store["zipcode"] as? String,
                                phone: store["phone"] as? String,
                                storeID: store["storeID"] as? String,
                                state: store["state"] as? String,
                                image: self?.fetchImage(url: store["storeLogoURL"] as! String)))
                            
                            //tmp.append(Store(dictionary: store, city: <#String#>, name: <#String#>))
                        }
                        DispatchQueue.main.sync {
                            self?.stores = tmp
                            
                            self?.refresher.endRefreshing()
                        }

                        // confirmed value if the array has been filled
                        print(" confirming \(self?.stores.count ?? 0)")
                    }
                } catch let err as NSError  {
                    print(" this as an arror : \(err)")
                }
            } else {
                print(error!)
            }
        }
        task.resume()
    }
    
    
    private func fetchImage(url: String) -> UIImage {
        
        let urlString = URL(string: url)
        
        var image = UIImage()
        
        if let imageData: NSData = NSData(contentsOf: urlString!) {
            image = UIImage(data: imageData as Data)!
        }
        
        return image
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        
        activityIndicator.activityIndicatorViewStyle = .gray
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        tableView.addSubview(activityIndicator)
        
        refresher.attributedTitle = NSAttributedString(string: "Pull to refresh!")
        refresher.addTarget(self, action: #selector(MainTVC.updateTable), for: UIControlEvents.valueChanged)
        
        tableView.addSubview(refresher)
        
        updateTable()
        self.refresher.endRefreshing()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.stores.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoreCell", for: indexPath)
        
        // Configure the cell...
        let newStore = self.stores[indexPath.row]
        
        if let storeCell = cell as? StoreTVCell {
            storeCell.store = newStore
        }
        
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        guard let identifier = segue.identifier else { return }
        switch identifier {
        case "Details":
            guard let destination = segue.destination as? DetailsVC else {
                return
            }
            guard let selectedCell = sender as? StoreTVCell else {
                return
            }
            guard let indexPath = tableView.indexPath(for: selectedCell) else {
                return
            }
            let selected = self.stores[indexPath.row]
            destination.store = selected
            
        default:
            fatalError("Unexpected Segue Identifier!")
        }
    }

}
