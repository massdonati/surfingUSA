//
//  APIManager.swift
//  SurfingUSA
//
//  Created by massimo on 24/11/15.
//  Copyright © 2015 Team84. All rights reserved.
//

import UIKit
import CoreData

class APIManager: NSObject {
    static let sharedManager = APIManager()
    
    private let hostNameURL = "http://api.spitcast.com/"
    
    //county
    private let spotsByCountyNameURL =              "api/county/spots/" //countyName
    private let swellByCountyNameURL =              "api/county/swell/" //countyName
    private let tideByCountyNameURL =               "api/county/tide/" //countyName
    private let waterTemperatureByCountyNameURL =   "api/county/water-temperature/" //countyName
    private let windByCountyNameURL =               "api/county/wind/" //countyName
    
    //spots
    private let allSpotsURL =                       "api/spot/all"
    private let spotForecastURL =                   "api/spot/forecast/" //spotID
    private let spotNearBY =                        "api/spot/nearby" //spotID
    private let neighborSpots =                     "api/spot/neighbors/" //spotID
    private let spotForecat =                       "api/spot-forecast/search"
    private let topSpots =                          "api/top/spots/"

    
    private func performRequest(stringURL: String, completionBlock:( NSData?, NSURLResponse?, NSError?) -> Void) {
        let session = NSURLSession.sharedSession()
        let url = NSURL(string: stringURL)!
        
        session.dataTaskWithURL(url, completionHandler: completionBlock).resume()
    }
    
    internal func getSpots(completionBlock: ([Spot])->(Void)) {
        let session = NSURLSession.sharedSession()
        let spotsURL = NSURL(string: hostNameURL + allSpotsURL)!

        session.dataTaskWithURL(spotsURL) {
            (data, response, error) -> Void in
            guard let data = data where error == nil else {
                print("there was an error")
                return;
            }
            
            do {
                let jsonResponse = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as! NSArray
                var spots = [Spot]()
                for jsonSpot in jsonResponse {
                    let spotDescription = NSEntityDescription.entityForName("Spot", inManagedObjectContext: AppDelegate.sharedDelegate.managedObjectContext)
                    let spot = Spot.init(entity: spotDescription!, insertIntoManagedObjectContext: AppDelegate.sharedDelegate.managedObjectContext)
                    
                    spot.populate(jsonSpot as! [String : AnyObject])
                    spots.append(spot)
                }
                completionBlock(spots)
                
            } catch let myJSONError {
                print(myJSONError)
            }
        }.resume()
    }
    
    private func prepare(county: String) -> String {

        return county.lowercaseString.stringByReplacingOccurrencesOfString(" ", withString: "-") + "/"
    }
    
    internal func getSpots(county:String, completionBlock: ([Spot])->(Void)) {
        
        let name = prepare(county)
        performRequest(hostNameURL + spotsByCountyNameURL + name) { (data, response, error) -> Void in
            guard let data = data where error == nil else {
                print("there was an error")
                return;
            }
            do {
                let jsonResponse = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as! NSArray
                var spots = [Spot]()
                for jsonSpot in jsonResponse {
                    let spotDescription = NSEntityDescription.entityForName("Spot", inManagedObjectContext: AppDelegate.sharedDelegate.managedObjectContext)
                    let spot = Spot.init(entity: spotDescription!, insertIntoManagedObjectContext: AppDelegate.sharedDelegate.managedObjectContext)
                    
                    spot.populate(jsonSpot as! [String : AnyObject])
                    spots.append(spot)
                }
                completionBlock(spots)
                
            } catch let myJSONError {
                print(myJSONError)
            }
        }
    }
    
}
