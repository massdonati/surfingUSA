//
//  GetCountyListOperation.swift
//  SurfingUSA
//
//  Created by massimo on 28/11/15.
//  Copyright © 2015 Team84. All rights reserved.
//

import UIKit
import CoreData

class FetchCountyListOperation: Operation {

    var loadHandler: ([String]?, ErrorType?) -> Void
    var spotsArray = [Spot]()
    
    init(loadHandler: ([String]?, ErrorType?) -> Void) {
        self.loadHandler = loadHandler
        super.init()
    }
    
    override func execute() {
        
        let fetchRequest = NSFetchRequest(entityName: "Spot")
        
        do {
            spotsArray = try AppDelegate.sharedDelegate.managedObjectContext.executeFetchRequest(fetchRequest) as! [Spot]
                self.countiesFromSpots()
        }
        catch let fetchRequestError {
            print(fetchRequestError)
            self.loadHandler(nil, fetchRequestError)
            self.finish()
        }
    }
    
    func countiesFromSpots() {
        let countyArray = self.spotsArray.reduce([] , combine:{counties, spot in
            if let countyName = spot.county {
                if counties.containsObject(countyName) {
                    return counties
                }
                return counties.arrayByAddingObject(countyName)
            }
            return counties
        })
        self.loadHandler(countyArray as? [String], nil)
        self.finish()
    }
    
}
