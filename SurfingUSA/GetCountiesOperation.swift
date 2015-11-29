//
//  GetCountyOperation.swift
//  SurfingUSA
//
//  Created by massimo on 28/11/15.
//  Copyright © 2015 Team84. All rights reserved.
//

import UIKit

class GetCountiesOperation: Operation {
    var loadHandler: ([String]?, ErrorType?) -> Void
    
    var internalQueue = NSOperationQueue()
    
    init(loadHandler: ([String]?, ErrorType?) -> Void) {
        self.loadHandler = loadHandler
        super.init()
    }
    
    override func execute() {
        // create a get all spots operation and than chain a filter operation
        
        let getSpotsOperation = GetAllSpotsOperation()
        
        let buildCountyListOperation = FetchCountyListOperation { (counties, error) -> Void in
            self.loadHandler(counties, error)
            self.finish()
        }
        
        buildCountyListOperation.addDependency(getSpotsOperation)
        
        internalQueue.addOperations([getSpotsOperation, buildCountyListOperation], waitUntilFinished: false)
    }
}
