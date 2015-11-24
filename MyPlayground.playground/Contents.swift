////: Playground - noun: a place where people can play
//
import UIKit
import XCPlayground
XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

let url = NSURL(string: "http://api.spitcast.com/api/spot/all")!

let task = NSURLSession.sharedSession().dataTaskWithURL(url) {(data, response, error) in
    print(response)
}

task.resume()

let session = NSURLSession.sharedSession()

session.dataTaskWithURL(url) { (data, response, error) -> Void in
    print(data)
    do {
        let jsonResponse = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers)
    } catch let myJSONError {
        print(myJSONError)
    }
//    try! let dictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers)
    XCPlaygroundPage.currentPage.finishExecution()
}.resume()

