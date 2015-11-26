////: Playground - noun: a place where people can play
//
import UIKit
import XCPlayground
XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

let url = NSURL(string: "http://api.spitcast.com/api/spot/all")!

let session = NSURLSession.sharedSession()

session.dataTaskWithURL(url) { (data, response, error) -> Void in
    print(data)
    do {
        let jsonResponse = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers)
        print(jsonResponse[0])
    } catch let myJSONError {
        print(myJSONError)
    }
//    try! let dictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers)
    XCPlaygroundPage.currentPage.finishExecution()
}.resume()



