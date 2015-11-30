//
//  Spot.swift
//  SurfingUSA
//
//  Created by Massimo Donati on 11/25/15.
//  Copyright © 2015 Team84. All rights reserved.
//

import Foundation
import CoreData


class Spot: NSManagedObject {

    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    func populate(jsonData: [String: AnyObject]) -> Spot? {
        
        if let countyName = jsonData["county_name"] as? String {
            self.county = countyName
        }
        
        if let countyName = jsonData["county"] as? String {
            self.county = countyName
        }
        
        
        if let latitude = jsonData["latitude"] as? Double,
            let longitude = jsonData["longitude"] as? Double,
            let spotID = jsonData["spot_id"] as? Double,
            let name = jsonData["spot_name"] as? String
        {
            
            self.latitude = Double(latitude)
            self.longitude = Double(longitude)
            self.spotID = spotID
            self.name = name
        }
        else {
            return nil
        }

        return self
    }

}
