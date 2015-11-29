//
//  GetAllSpotsOperation.swift
//  SurfingUSA
//
//  Created by massimo on 28/11/15.
//  Copyright © 2015 Team84. All rights reserved.
//

import UIKit

class GetAllSpotsOperation: Operation {

    override func execute() {
        APIManager.sharedManager.getSpots { (spots) -> (Void) in
            self.finish()
        }
    }
    
}
