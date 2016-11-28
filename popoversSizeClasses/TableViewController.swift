//
//  TableViewController.swift
//  popoversSizeClasses
//
//  Created by Patrick Pahl on 11/26/16.
//  Copyright © 2016 Patrick Pahl. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetailSegue" {
            if let indexPath = tableView.indexPath(for: (sender as? UITableViewCell)!) {
                if let detailViewController = segue.destination as? DetailViewController {
                    detailViewController.detailText = "Item \(indexPath.row)"
                }
            }
        }
    }
    
    
    
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "ShowDetailSegue" {
//            if let indexPath = tableView.indexPathForCell(sender as! UITableViewCell) {
//                if let detailViewController = segue.destinationViewController as? DetailViewController {
//                    detailViewController.detailText = "Item \(indexPath.row)"
//                }
//            }
//        }
//    }
    
    
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = "Item \(indexPath.row)"
        
        return cell
    }

}
