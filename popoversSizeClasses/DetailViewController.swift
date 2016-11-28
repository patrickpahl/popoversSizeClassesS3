//
//  DetailViewController.swift
//  popoversSizeClasses
//
//  Created by Patrick Pahl on 11/27/16.
//  Copyright © 2016 Patrick Pahl. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var detailLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    detailLabel?.text = detailText
    title = detailText
    }

    var detailText = "No Detail"

}
