//
//  ViewControllerMainMenu.swift
//  VimySoldierEntry
//
//  Created by Student on 2015-06-09.
//  Copyright (c) 2015 Mason Black. All rights reserved.
//

import Foundation
import UIKit

class ViewControllerMainMenu: UIViewController {
    
    @IBOutlet weak var getStarted: UIButton!
    
    @IBAction func btnSubmit(sender: AnyObject) {
        
        var totalPost = ""
        
        var request = NSMutableURLRequest(URL: NSURL(string: "http://www.lest-we-forget.ca/apis/ww1_mobile_edit_soldier_api.php")!, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData, timeoutInterval: 5)
        var response: NSURLResponse?
        var error: NSError?
        var jsonStr = MyVariables.globalSoldier.makeJSON()
        var err: NSError?
        
        request.HTTPMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        // Take all of the information stored in totalPost and format it so that it can be sent to the server
        request.HTTPBody = totalPost.dataUsingEncoding(NSUTF8StringEncoding);
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue())
            {
                (response, data, error) in
                //println(response)
                //println(data.description)
                
                // look at the response
                if let httpResponse = response as? NSHTTPURLResponse {
                    //println("HTTP response: \(httpResponse.description)")
                } else {
                    println("No HTTP response")
                }
                
        }
        
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler:{ (response:NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            // look at the response
            if let httpResponse = response as? NSHTTPURLResponse {
                //println("HTTP response: \(httpResponse.description)")
            } else {
                println("No HTTP response")
            }
        })
        
        dispatch_async(dispatch_get_main_queue()) {
            self.performSegueWithIdentifier("AuthSegue", sender: self)
        }

    }
    
    
    
    
    
    
}