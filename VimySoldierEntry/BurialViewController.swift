//
//  BurialViewController.swift
//  VimySoldierEntry
//
//  Created by Student on 2015-06-01.
//  Copyright (c) 2015 Mason Black. All rights reserved.
//

import UIKit

class BurialViewController: UIViewController {

    @IBOutlet weak var txtCauseOfDeath: UITextField!
    @IBOutlet weak var txtNameOnGrave: UITextField!
    @IBOutlet weak var txtRemainsBuriedInCemetery: UITextField!
    @IBOutlet weak var txtRemainsBuriedInCityVillage: UITextField!
    @IBOutlet weak var txtRemainsBuriedInCountry: UITextField!
    @IBOutlet weak var txtRemainsBuriedInGrave: UITextField!
    @IBOutlet weak var txtRemainsBuriedInPlot: UITextField!
    @IBOutlet weak var txtRemainsBuriedInRow: UITextField!
    @IBOutlet weak var txtAgeatDeath: UITextField!
    @IBOutlet weak var txtDeathLocation: UITextField!
    @IBOutlet weak var txtDiedAt: UITextField!
   
    @IBOutlet weak var switchReburied: UISwitch!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var txtDateOfDeath: UIDatePicker!
    
    @IBAction func dateChosen(sender: AnyObject) {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        var strDate = dateFormatter.stringFromDate(txtDateOfDeath.date)
        dateLabel.text = strDate
        MyVariables.globalSoldier.date_of_death = strDate
    }
    
    @IBAction func btn_submit(sender: AnyObject) {
        var totalPost: String = ""
        
        //get the Access_Code and soldier_id from the last form
        if MyVariables.globalSoldier.soldier_id != "" {
            totalPost += "&soldier_id=" + MyVariables.globalSoldier.soldier_id
        }
        
        if MyVariables.access_code != "" {
            totalPost += "&access_code=" + MyVariables.access_code
        }
       
        if (txtCauseOfDeath.text != ""){
            MyVariables.globalSoldier.cause_of_death = txtCauseOfDeath.text
            totalPost += "&cause_of_death=" + MyVariables.globalSoldier.cause_of_death
        }
        if (txtNameOnGrave.text != ""){
            MyVariables.globalSoldier.name_on_grave = txtNameOnGrave.text
            totalPost += "&name_on_grave=" + MyVariables.globalSoldier.name_on_grave
        }
        if (txtRemainsBuriedInCemetery.text != ""){
            MyVariables.globalSoldier.remains_buried_in_cemetery = txtRemainsBuriedInCemetery.text
            totalPost += "&remains_buried_in_cemetery=" + MyVariables.globalSoldier.remains_buried_in_cemetery
        }
        if (txtRemainsBuriedInCityVillage.text != ""){
            MyVariables.globalSoldier.remains_buried_in_city_village = txtRemainsBuriedInCityVillage.text
            totalPost += "&remains_buried_in_city_village=" + MyVariables.globalSoldier.remains_buried_in_city_village
        }
        if (txtRemainsBuriedInCountry.text != ""){
            MyVariables.globalSoldier.remains_buried_in_country = txtRemainsBuriedInCountry.text
            totalPost += "&remains_buried_in_country=" + MyVariables.globalSoldier.remains_buried_in_country
        }
        if (txtRemainsBuriedInGrave.text != ""){
            MyVariables.globalSoldier.remains_buried_in_grave = txtRemainsBuriedInGrave.text
            totalPost += "&remains_buried_in_grave=" + MyVariables.globalSoldier.remains_buried_in_grave
        }
        if (txtRemainsBuriedInPlot.text != ""){
            MyVariables.globalSoldier.remains_buried_in_plot = txtRemainsBuriedInPlot.text
            totalPost += "&remains_buried_in_plot=" + MyVariables.globalSoldier.remains_buried_in_plot
        }
        if (txtRemainsBuriedInRow.text != ""){
            MyVariables.globalSoldier.remains_buried_in_row = txtRemainsBuriedInRow.text
            totalPost += "&remains_buried_in_row=" + MyVariables.globalSoldier.remains_buried_in_row
        }
        if (MyVariables.globalSoldier.date_of_death != "") {
            totalPost += "&date_of_death=" + MyVariables.globalSoldier.date_of_death
        }
        if (txtAgeatDeath.text != "") {
            MyVariables.globalSoldier.age_at_death = txtAgeatDeath.text
            totalPost += "&age_at_death=" + MyVariables.globalSoldier.age_at_death
        }
        if (txtDeathLocation.text !=  "") {
            MyVariables.globalSoldier.location_of_death = txtDeathLocation.text
            totalPost += "&location_of_death=" + MyVariables.globalSoldier.location_of_death
        }
        if (txtDiedAt.text !=  "") {
            MyVariables.globalSoldier.died_at = txtDiedAt.text
            totalPost += "&died_at=" + MyVariables.globalSoldier.died_at
        }
        
        if (switchReburied.on)
        {
            MyVariables.globalSoldier.soldier_reburied = "yes"
            totalPost += "&soldier_reburied=" + MyVariables.globalSoldier.soldier_reburied
        }
        else
        {
            MyVariables.globalSoldier.soldier_reburied = "no"
            totalPost += "&soldier_reburied=" + MyVariables.globalSoldier.soldier_reburied
        }
        
        
        totalPost += "&table=Regimental3_Temp_WW1"
        //println(totalPost)
        
        var request = NSMutableURLRequest(URL: NSURL(string: "http://www.lest-we-forget.ca/apis/ww1_mobile_edit_soldier_api.php")!, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData, timeoutInterval: 5)
        var response: NSURLResponse?
        var error: NSError?
        var jsonStr = MyVariables.globalSoldier.makeJSON()
        var err: NSError?
        
        // *** Help File Descriptor 10
        request.HTTPMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        // Take all of the information stored in totalPost and format it so that it can be sent to the server
        request.HTTPBody = totalPost.dataUsingEncoding(NSUTF8StringEncoding);
        
        
        // *** Help File Descriptor 11
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
        
        
//        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler:{ (response:NSURLResponse!, data: NSData!, error: NSError!) -> Void in
//            // look at the response
//            if let httpResponse = response as? NSHTTPURLResponse {
//                //println("HTTP response: \(httpResponse.description)")
//            } else {
//                println("No HTTP response")
//            }
//        })
        
    }
     //weak var switchReburied: UISwitch!
    
     override func viewDidLoad() {
        super.viewDidLoad()

        txtCauseOfDeath.text = MyVariables.globalSoldier.cause_of_death
        txtNameOnGrave.text = MyVariables.globalSoldier.name_on_grave
        txtRemainsBuriedInCemetery.text = MyVariables.globalSoldier.remains_buried_in_cemetery
        txtRemainsBuriedInCityVillage.text = MyVariables.globalSoldier.remains_buried_in_city_village
        txtRemainsBuriedInCountry.text = MyVariables.globalSoldier.remains_buried_in_country
        txtRemainsBuriedInGrave.text = MyVariables.globalSoldier.remains_buried_in_grave
        txtRemainsBuriedInPlot.text = MyVariables.globalSoldier.remains_buried_in_plot
        txtRemainsBuriedInRow.text = MyVariables.globalSoldier.remains_buried_in_row
        txtDeathLocation.text = MyVariables.globalSoldier.location_of_death
        txtAgeatDeath.text = MyVariables.globalSoldier.age_at_death
        txtDiedAt.text = MyVariables.globalSoldier.died_at
        
        if (MyVariables.globalSoldier.soldier_reburied == "yes")
        {
            switchReburied.on = true
        }
        else if (MyVariables.globalSoldier.soldier_reburied == "no")
        {
            switchReburied.on = false
        }
        
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        var newDate = dateFormatter.dateFromString(MyVariables.globalSoldier.date_of_death)
        //txtDateOfDeath.date = newDate!
        if let dateOfDeath = dateFormatter.dateFromString(MyVariables.globalSoldier.date_of_death){
            txtDateOfDeath.date = dateOfDeath
        }
        else {
            let newDate = dateFormatter.dateFromString("1918-11-11")
        }
    }
    

     override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
