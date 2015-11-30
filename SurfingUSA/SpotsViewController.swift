//
//  SpotsViewController.swift
//  SurfingUSA
//
//  Created by Massimo Donati on 11/30/15.
//  Copyright © 2015 Team84. All rights reserved.
//

import UIKit

class SpotsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var spots: [Spot]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let spotsArray = spots else {
            return UITableViewCell()
        }
        let cell = tableView.dequeueReusableCellWithIdentifier("spotCell")! as UITableViewCell
        
        let currentSpot = spotsArray[indexPath.row]
        
        cell.textLabel?.text = currentSpot.name! + " (" + currentSpot.county! + ")"
        cell.detailTextLabel?.text = "\(currentSpot.latitude!) \(currentSpot.longitude!)"
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let spotsArray = spots else {
            return 0
        }
        
        return spotsArray.count
    }

}
