////: Playground - noun: a place where people can play
//
import UIKit
import CoreData
import XCPlayground
XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

let url = NSURL(string: "https://api.imgur.com/oauth2/authorize")!//?response_type=token&client_id=760de1df3beaca0&state=ciccio

let session = NSURLSession.sharedSession()

let params:[String: String] = [
    "client_id" : "760de1df3beaca0",
    "response_type" : "pin",
    "state" : "ciccio"
]

var err: NSError?

let request = NSMutableURLRequest(URL: url)
request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(params, options: NSJSONWritingOptions())
request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
request.HTTPMethod = "POST"

print(request)

session.dataTaskWithRequest(request) { (data, response, error) -> Void in
    print(NSString(data: data!, encoding:NSUTF8StringEncoding))
    do {
        let jsonResponse = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
    } catch let myJSONError {
        print(myJSONError)
    }
    XCPlaygroundPage.currentPage.finishExecution()
}.resume()