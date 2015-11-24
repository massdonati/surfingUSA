//
//  APIManager.swift
//  SurfingUSA
//
//  Created by massimo on 24/11/15.
//  Copyright © 2015 Team84. All rights reserved.
//

import UIKit

class APIManager: NSObject {
    static let sharedManager = APIManager()
    
    let hostNameURL = "http://api.spitcast.com/"
    
    //county
    let spotsByCountyNameURL =              "api/county/spots/" //countyName
    let swellByCountyNameURL =              "api/county/swell/" //countyName
    let tideByCountyNameURL =               "api/county/tide/" //countyName
    let waterTemperatureByCountyNameURL =   "api/county/water-temperature/" //countyName
    let windByCountyNameURL =               "api/county/wind/" //countyName
    
    //spots
    let allSpotsURL =                       "api/spot/all"
    let spotForecastURL =                   "api/spot/forecast/" //spotID
    let spotNearBY =                        "api/spot/nearby" //spotID
    let neighborSpots =                     "api/spot/neighbors/" //spotID
    let spotForecat =                       "api/spot-forecast/search"
    let topSpots =                          "api/top/spots/"

}
