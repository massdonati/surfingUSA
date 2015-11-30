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
    
    var countiesArray = [String]()
    let operationQueue = NSOperationQueue()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        //GetCountiesOperation does two things: gets all the spots and storethem into a core data db an fetches all the counties from the db. (not very efficent but a good demo)
        let countyListOperation = GetCountiesOperation { (counties, error) -> Void in
            if let error = error {
                print("Error getting county list \(error)")
                return
            }
            
            if let counties = counties  {
                self.countiesArray = counties
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.tableView.reloadData()
                })
            }
        }
        operationQueue.addOperation(countyListOperation)

    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        APIManager.sharedManager.getSpots(self.countiesArray[indexPath.row]) { (spots) -> (Void) in
            
            let spotsVC = self.storyboard?.instantiateViewControllerWithIdentifier("SpotsViewController") as! SpotsViewController
            spotsVC.spots = spots
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.navigationController?.pushViewController(spotsVC, animated: true)
            })
            
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countiesArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("spotCell", forIndexPath: indexPath)
        
        cell.textLabel?.text = countiesArray[indexPath.row]
        
        return cell
        
    }

}

