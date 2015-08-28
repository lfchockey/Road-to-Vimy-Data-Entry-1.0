//
//  File.swift
//  VimySoldierEntry
//
//  Created by Student on 2015-05-13.
//  Copyright (c) 2015 Mason Black. All rights reserved.
//

import UIKit

class ViewControllerMedical: UIViewController, UITextFieldDelegate {
  
    
    //@IBOutlet weak var selectedDate: UILabel!
    @IBOutlet weak var dateexamined: UIDatePicker!
   
    @IBOutlet weak var txtweight: UITextField!
    @IBOutlet weak var txtheightInches: UITextField!
    @IBOutlet weak var txtheightFeet: UITextField!
    @IBOutlet weak var txtageMonths: UITextField!
    @IBOutlet weak var txtageYears: UITextField!
    @IBOutlet weak var txtplaceExamined: UITextField!
    @IBOutlet weak var seggender: UISegmentedControl!
    @IBOutlet weak var submit: UIButton!
    
    var examinedDate: String = ""
    
    @IBAction func datechosen(sender: AnyObject) {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-M-d"
        examinedDate = dateFormatter.stringFromDate(dateexamined.date)
        //selectedDate.text = examinedDate
        
        MyVariables.globalSoldier.date_examined = examinedDate
    }
    
    
    
    
    @IBAction func submitMedical(sender: AnyObject) {
        var dateExamined: String
        var placeExamined: String
        var gender: String
        var ageYears: String
        var ageMonths: String
        var heightFeet: String
        var heightInches: String
        var weight: String
        
        
        dateExamined = examinedDate
        placeExamined = txtplaceExamined.text
        ageYears = txtageYears.text
        ageMonths = txtageMonths.text
        heightFeet = txtheightFeet.text
        heightInches = txtheightInches.text
        weight = txtweight.text
       
        var alert = UIAlertController(title: "Alert", message: "You must fill in all information completely", preferredStyle: UIAlertControllerStyle.Alert)
        
        //if ( dateExamined == "" || placeExamined == "" || ageMonths == "" || ageYears == "" || heightFeet == "" || heightInches == "" || weight == "") {
        //alert.addAction(UIAlertAction(title: "Update Information", style: UIAlertActionStyle.Default, handler: nil))
            
            //self.presentViewController(alert, animated: true, completion: nil)
            
            var totalPost: String = ""
            
            if MyVariables.globalSoldier.soldier_id != "" {
                totalPost += "&soldier_id=" + MyVariables.globalSoldier.soldier_id
            }
            
            if MyVariables.access_code != "" {
                totalPost += "&access_code=" + MyVariables.access_code
            }
         
//            if (examinedDate != ""){
//                MyVariables.globalSoldier.date_examined = examinedDate
//                totalPost += "&date_examined=" + MyVariables.globalSoldier.date_examined
//            }
        
            if (txtplaceExamined.text != ""){
                MyVariables.globalSoldier.place_examined = txtplaceExamined.text
                totalPost += "&place_examined=" + MyVariables.globalSoldier.place_examined
            }
            
            if (seggender.selectedSegmentIndex == 0 ){
                MyVariables.globalSoldier.gender = "male"
                totalPost += "&gender=" + MyVariables.globalSoldier.gender
            }
            if (seggender.selectedSegmentIndex == 1 ){
                MyVariables.globalSoldier.gender = "female"
                totalPost += "&gender=" + MyVariables.globalSoldier.gender
            }
            if (seggender.selectedSegmentIndex == 2 ){
                MyVariables.globalSoldier.gender = "not sure"
                totalPost += "&gender=" + MyVariables.globalSoldier.gender
            }
            
            if (txtageYears.text != ""){
                MyVariables.globalSoldier.age_years_medical = txtageYears.text
                totalPost += "&age_years_medical=" + MyVariables.globalSoldier.age_years_medical
            }
            
            if (txtageMonths.text != ""){
                MyVariables.globalSoldier.age_months_medical = txtageMonths.text
                totalPost += "&age_months_medical=" + MyVariables.globalSoldier.age_months_medical
            }
            
            if (txtheightFeet.text != ""){
                MyVariables.globalSoldier.height_feet = txtheightFeet.text
                totalPost += "&height_feet=" + MyVariables.globalSoldier.height_feet
            }
            
            if (txtheightInches.text != ""){
                MyVariables.globalSoldier.height_inches = txtheightInches.text
                totalPost += "&height_inches=" + MyVariables.globalSoldier.height_inches
            }
            
            if (txtweight.text != ""){
                MyVariables.globalSoldier.weight = txtweight.text
                totalPost += "&weight=" + MyVariables.globalSoldier.weight
            }
        
            if MyVariables.globalSoldier.date_examined != "" {
                totalPost += "&date_examined=" + MyVariables.globalSoldier.date_examined
            }
            
            totalPost += "&table=Medical_History1_Temp_WW1"
            
            //println(totalPost)
            
            // create the request & response
            
            //var request = NSMutableURLRequest(URL: NSURL(string: "http://requestb.in/yanvmlya")!, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData, timeoutInterval: 5)
            var request = NSMutableURLRequest(URL: NSURL(string: "http://www.lest-we-forget.ca/apis/ww1_mobile_edit_soldier_api.php")!, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData, timeoutInterval: 5)
            var response: NSURLResponse?
            var error: NSError?
            var jsonStr = MyVariables.globalSoldier.makeJSON()
            var err: NSError?
        
            request.HTTPMethod = "POST"
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            // Take all of the information stored in totalPost and format it so that it can be sent to the server
            request.HTTPBody = totalPost.dataUsingEncoding(NSUTF8StringEncoding);

    
        
        // *** Help File Descriptor 11
        // Send the request to the server
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue())
            {
                (response, data, error) in
                //println(response)

                
                // look at the response
                if let httpResponse = response as? NSHTTPURLResponse {
                    //println("HTTP response: \(httpResponse.description)")
                } else {
                    println("No HTTP response")
                }
                
            }
        
        
//        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler:{ (response:NSURLResponse!, data: NSData!, error: NSError!) -> Void in
//            // look at the response
//            if let httpResponse = response as? NSHTTPURLResponse {
//                //println("HTTP response: \(httpResponse.description)")
//            } else {
//                println("No HTTP response")
//            }
//        })
            dispatch_async(dispatch_get_main_queue()) {
                self.performSegueWithIdentifier("Med2Segue", sender: self)
            }
    }

    
        override func viewDidLoad() {
            super.viewDidLoad()
            
            var dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            if let examDate = dateFormatter.dateFromString(MyVariables.globalSoldier.date_examined)
            {
                println(MyVariables.globalSoldier.date_examined)
                dateexamined.date = examDate
            }
            else {
                //let newDate = dateFormatter.dateFromString("1888-08-08")
                //dateexamined.date = newDate!
            }
            
            //selectedDate.text = MyVariables.globalSoldier.date_examined
            txtplaceExamined.text = MyVariables.globalSoldier.place_examined
            txtageYears.text = MyVariables.globalSoldier.age_years_medical
            txtageMonths.text = MyVariables.globalSoldier.age_months_medical
            txtheightInches.text = MyVariables.globalSoldier.height_inches
            txtheightFeet.text = MyVariables.globalSoldier.height_feet
            txtweight.text = MyVariables.globalSoldier.weight
            
            switch MyVariables.globalSoldier.gender {
            case "male" :
                seggender.selectedSegmentIndex = 0
            case "female" :
                seggender.selectedSegmentIndex = 1
            case "not sure" :
                seggender.selectedSegmentIndex = 2
            default:
                seggender.selectedSegmentIndex = 2
            }
            
        }
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }

}

