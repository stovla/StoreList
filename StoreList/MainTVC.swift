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
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.tableView.reloadData()
                self.refresher.endRefreshing()
            }
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
                    let jsonData = try JSONDecoder().decode(StoreResponse.self, from: usableData)
                    self?.stores = jsonData.stores
                    
                    print(" confirming \(self?.stores.count ?? 0)")
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
        
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = tableView.rowHeight
        
        activityIndicator.style = .gray
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        tableView.addSubview(activityIndicator)
        
        refresher.attributedTitle = NSAttributedString(string: "Pull to refresh!")
        refresher.addTarget(self, action: #selector(MainTVC.updateTable), for: UIControl.Event.valueChanged)
        
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
        
        if indexPath.row.isMultiple(of: 2) {
            cell.backgroundColor = .cyan
        } else {
            cell.backgroundColor = .white
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
            destination.store = selectedCell.store
            
        default:
            fatalError("Unexpected Segue Identifier!")
        }
    }

}
