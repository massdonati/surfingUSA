//
//  ViewController.swift
//  SurfingUSA
//
//  Created by massimo on 23/11/15.
//  Copyright © 2015 Team84. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var spotsArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        let fetchRequest = NSFetchRequest(entityName: "Spot")
        
        do {
            let spots = try AppDelegate.sharedDelegate.managedObjectContext.executeFetchRequest(fetchRequest) as! [Spot]
            if spots.count == 0 {
                APIManager.sharedManager.getSpots { (spots) -> (Void) in
                    self.spotsArray = spots.reduce([], combine:{counties, spot in
                        if counties.contains(spot.county!) {
                            return counties
                        }
                        return counties + [spot.county!]
                        })
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.tableView.reloadData()
                    })
                }
            }
        }
        catch let fetchRequestError {
            print(fetchRequestError)
        }
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        APIManager.sharedManager.getSpots(self.spotsArray[indexPath.row]) { (spots) -> (Void) in
            print(spots)
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return spotsArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("spotCell", forIndexPath: indexPath)
        
        cell.textLabel?.text = spotsArray[indexPath.row]
        
        return cell
        
    }

}

