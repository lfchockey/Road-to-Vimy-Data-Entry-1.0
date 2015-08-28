//
//  ViewControllerFinalSubmit.swift
//  VimySoldierEntry
//
//  Created by Mason Black on 2015-08-20.
//  Copyright (c) 2015 Mason Black. All rights reserved.
//

import UIKit

class ViewControllerFinalSubmit: UIViewController {

    @IBOutlet weak var txtStudentName: UITextField!
    @IBOutlet weak var txtStudentVerified: UITextField!
    @IBOutlet weak var txtSchool: UITextField!
    
    @IBAction func btnSubmitClick(sender: AnyObject) {
        var student_name = txtStudentName.text
        var student_verified = txtStudentVerified.text
        var school = txtSchool.text
        
        var totalPost: String = ""
        
        if MyVariables.globalSoldier.soldier_id != "" {
            totalPost += "soldier_id=" + MyVariables.globalSoldier.soldier_id
        }
        
        if MyVariables.access_code != "" {
            totalPost += "&access_code=" + MyVariables.access_code
        }

        var url : String = "http://www.lest-we-forget.ca/dataentry/ww1_thankyou.php?\(totalPost)"
        
        //println(totalPost)
        
        var request = NSMutableURLRequest(URL: NSURL(string: url)!, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData, timeoutInterval: 5)
        var response: NSURLResponse?
        var error: NSError?
        //var jsonStr = MyVariables.globalSoldier.makeJSON()
        var err: NSError?
        
        request.HTTPMethod = "GET"
        //request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        // Take all of the information stored in totalPost and format it so that it can be sent to the server
        //request.HTTPBody = totalPost.dataUsingEncoding(NSUTF8StringEncoding);
        
        // Send the request to the server
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue())
        {
            (response, data, error) in
            
            // look at the response
            if let httpResponse = response as? NSHTTPURLResponse {
                //println("HTTP response: \(httpResponse.description)")
            } else {
                println("No HTTP response")
            }

        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
