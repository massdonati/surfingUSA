//
//  Spot+CoreDataProperties.swift
//  SurfingUSA
//
//  Created by Massimo Donati on 11/25/15.
//  Copyright © 2015 Team84. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Spot {

    @NSManaged var spotID: NSNumber?
    @NSManaged var name: String?
    @NSManaged var latitude: NSNumber?
    @NSManaged var longitude: NSNumber?
    @NSManaged var county: String?

}
