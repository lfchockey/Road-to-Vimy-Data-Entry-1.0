//
//   ViewControllerMedical2.swift
//  VimySoldierEntry
//
//  Created by Student on 2015-05-12.
//  Copyright (c) 2015 Mason Black. All rights reserved.
//

import Foundation
import UIKit

class ViewControllerMedical2: UIViewController {
    
    @IBOutlet weak var txtTradeOccu: UITextField!
    @IBOutlet weak var txtChestMinExp: UITextField!
    @IBOutlet weak var txtChestMaxExp: UITextField!
    @IBOutlet weak var txtPhysDev: UITextField!
    @IBOutlet weak var txtVacMarksLeft: UITextField!
    @IBOutlet weak var txtVacMarksRight: UITextField!
    @IBOutlet weak var txtVacMarksTotal: UITextField!
    @IBOutlet weak var txtPrevDiseaseMarks: UITextField!
    @IBOutlet weak var txtSlightDefects: UITextField!
    //@IBOutlet weak var txtIdentifyMarks: UITextField!
    @IBOutlet weak var switchDischarged: UISwitch!
    @IBOutlet weak var btnSubmit: UIButton!
    
    @IBAction func btn_Click(sender: AnyObject) {
        var totalPost: String = ""
        
        
        if MyVariables.globalSoldier.soldier_id != "" {
            totalPost += "&soldier_id=" + MyVariables.globalSoldier.soldier_id
        }
        if MyVariables.access_code != "" {
            totalPost += "&access_code=" + MyVariables.access_code
        }
        if (txtChestMaxExp.text != "") {
            MyVariables.globalSoldier.chest_maximum_expansion = txtChestMaxExp.text
            totalPost += "&chest_maximum_expansion=" + MyVariables.globalSoldier.chest_maximum_expansion
        }
        if (txtChestMinExp.text != "") {
            MyVariables.globalSoldier.chest_minimum = txtChestMinExp.text
            totalPost += "&chest_minimum=" + MyVariables.globalSoldier.chest_minimum
        }
// Found on the Attestation
//        if (txtIdentifyMarks.text != "") {
//            MyVariables.globalSoldier.identifying_marks = txtIdentifyMarks.text
//            totalPost += "&identifying_marks=" + MyVariables.globalSoldier.identifying_marks
//        }
        if (txtPhysDev.text != "") {
            MyVariables.globalSoldier.physical_development = txtPhysDev.text
            totalPost += "&physical_development=" + MyVariables.globalSoldier.physical_development
        }
        if (txtPrevDiseaseMarks.text != "") {
            MyVariables.globalSoldier.previous_disease_marks = txtPrevDiseaseMarks.text
            totalPost += "&previous_disease_marks=" + MyVariables.globalSoldier.previous_disease_marks
        }
        if (txtSlightDefects.text != "") {
            MyVariables.globalSoldier.slight_defects = txtSlightDefects.text
            totalPost += "&slight_defects=" + MyVariables.globalSoldier.slight_defects
        }
        if (txtTradeOccu.text != "") {
            MyVariables.globalSoldier.trade_or_occupation = txtTradeOccu.text
            totalPost += "&trade_or_occupation=" + MyVariables.globalSoldier.trade_or_occupation
        }
        if (txtVacMarksLeft != "") {
            MyVariables.globalSoldier.vaccination_marks_left_arm = txtVacMarksLeft.text
            totalPost += "&vaccination_marks_left_arm=" + MyVariables.globalSoldier.vaccination_marks_left_arm
        }
        if (txtVacMarksRight != "") {
            MyVariables.globalSoldier.vaccination_marks_right_arm = txtVacMarksRight.text
            totalPost += "&vaccination_marks_right_arm=" + MyVariables.globalSoldier.vaccination_marks_right_arm
        }
        if (txtVacMarksTotal != "") {
            MyVariables.globalSoldier.vaccination_marks_number = txtVacMarksTotal.text
            totalPost += "&vaccination_marks_number=" + MyVariables.globalSoldier.vaccination_marks_number
        }
        if(switchDischarged.on) {
            MyVariables.globalSoldier.examined_or_discharged = "yes"
            totalPost += "&examined_or_discharged=" + MyVariables.globalSoldier.examined_or_discharged
        }
        else {
            MyVariables.globalSoldier.examined_or_discharged = "no"
            totalPost += "&examined_or_discharged=" + MyVariables.globalSoldier.examined_or_discharged
        }
        
        totalPost += "&table=Medical_History2_Temp_WW1"
        
        var request = NSMutableURLRequest(URL: NSURL(string:"http://www.lest-we-forget.ca/apis/ww1_mobile_edit_soldier_api.php")!, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData, timeoutInterval: 5)
        var response: NSURLResponse?
        var error: NSError?
        var jsonStr = MyVariables.globalSoldier.makeJSON()
        var err: NSError?
        
        request.HTTPMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = totalPost.dataUsingEncoding(NSUTF8StringEncoding);
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler:{ (response:NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            // look at the response
            if let httpResponse = response as? NSHTTPURLResponse {
                //println("HTTP response: \(httpResponse.description)")
            } else {
                println("No HTTP response")
            }
        })
        
        
        dispatch_async(dispatch_get_main_queue()) {
            self.performSegueWithIdentifier("Reg1Segue", sender: self)
        }
        
        //println(totalPost)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.view.backgroundColor = UIColor(red: 194.0/255.0, green: 178.0/255.0, blue: 128.0/255.0, alpha: 1.0)
        
        //println(MyVariables.globalSoldier.chest_maximum_expansion)
        txtChestMaxExp.text = MyVariables.globalSoldier.chest_maximum_expansion
        txtChestMinExp.text = MyVariables.globalSoldier.chest_minimum
        //txtIdentifyMarks.text = MyVariables.globalSoldier.identifying_marks
        txtPhysDev.text = MyVariables.globalSoldier.physical_development
        txtPrevDiseaseMarks.text = MyVariables.globalSoldier.previous_disease_marks
        txtSlightDefects.text = MyVariables.globalSoldier.slight_defects
        txtTradeOccu.text = MyVariables.globalSoldier.trade_or_occupation
        txtVacMarksLeft.text = MyVariables.globalSoldier.vaccination_marks_left_arm
        txtVacMarksRight.text = MyVariables.globalSoldier.vaccination_marks_right_arm
        txtVacMarksTotal.text = MyVariables.globalSoldier.vaccination_marks_number
        if (MyVariables.globalSoldier.examined_or_discharged.lowercaseString == "yes") {
            switchDischarged.on = true
        }
        else {
            switchDischarged.on = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}