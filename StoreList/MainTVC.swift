//
//  MainTVC.swift
//  StoreList
//
//  Created by Vlastimir Radojevic on 8/10/17.
//  Copyright © 2017 Vlastimir Radojevic. All rights reserved.
//

import UIKit

class MainTVC: UITableViewController {
    
    var refresher = UIRefreshControl(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    
    let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    
   // @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    // stores object
    private var stores: [Store] = [] {
        didSet {
            tableView.reloadData()
           // spinner.stopAnimating()
            activityIndicator.stopAnimating()
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
                    let parsedJson = json?["stores"] as! [[String: Any]]
                    var tmp: [Store] = []
                    for store in parsedJson {
                        tmp.append(Store(dictionary: store))
                    }
                    DispatchQueue.main.sync {
                        self?.stores = tmp
                    }
                    
                    // confirmed value
                    print(" confirming \(self?.stores.count ?? 0)")
                    
                } catch let err as NSError  {
                    print("\(err)")
                }
            } else {
                print(error!)
            }
        }
        task.resume()
        
        tableView.reloadData()
        self.refresher.endRefreshing()
    }
    
    override var tableView: UITableView! {
        didSet {
            tableView.estimatedRowHeight = tableView.rowHeight
            tableView.rowHeight = UITableViewAutomaticDimension
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        activityIndicator.activityIndicatorViewStyle = .gray
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        tableView.addSubview(activityIndicator)
        
        refresher.attributedTitle = NSAttributedString(string: "Pull to refresh!")
        refresher.addTarget(self, action: #selector(MainTVC.updateTable), for: UIControlEvents.valueChanged)
        
        tableView.addSubview(refresher)
        
        updateTable()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
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
        
        switch (segue.identifier ?? "") {
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
            let image: UIImage = selectedCell.newImage!
            destination.image = image
            
        default:
            fatalError("Unexpected Segue Identifier!")
        }
    }
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    

}
