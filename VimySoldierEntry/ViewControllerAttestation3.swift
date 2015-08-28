//
//  ViewControllerAttestation2.swift
//  VimySoldierEntry
//
//  Created by Student on 2015-05-22.
//  Copyright (c) 2015 Mason Black. All rights reserved.
//

import Foundation
import UIKit

class ViewControllerAttestation3: UIViewController {
    @IBAction func SubmitAtt2(sender: AnyObject) {
        
    }

    @IBOutlet weak var Att2AgeYear: UITextField!
    @IBOutlet weak var Att2AgeMonth: UITextField!
    @IBOutlet weak var Att2Reilgion: UITextField!
    @IBOutlet weak var Att2HeightFeet: UITextField!
    @IBOutlet weak var Att2HeightInches: UITextField!
    @IBOutlet weak var Att2Weight: UITextField!
    @IBOutlet weak var Att2EyeColour: UITextField!
    @IBOutlet weak var Att2Complexion: UITextField!
    @IBOutlet weak var Att2ChestFullEx: UITextField!
    @IBOutlet weak var Att2ChestROE: UITextField!
    @IBOutlet weak var Att2IdentifyingMarks: UITextField!
    @IBOutlet weak var Att2EthnicOrigin: UITextField!
    @IBOutlet weak var Att2HairColour: UITextField!
    @IBOutlet weak var Att2TradeorCalling: UITextField!
    
    @IBAction func btn_Click(sender: AnyObject) {
        var totalPost: String = ""
        if MyVariables.globalSoldier.soldier_id != "" {
            totalPost += "&soldier_id=" + MyVariables.globalSoldier.soldier_id
        }
        if MyVariables.access_code != "" {
            totalPost += "&access_code=" + MyVariables.access_code
        }
        if (Att2AgeYear.text != "") {
        MyVariables.globalSoldier.apparent_age_years_att = Att2AgeYear.text
        totalPost += "&apparent_age_years_att=" + MyVariables.globalSoldier.apparent_age_years_att
        }
        if (Att2AgeMonth.text != "") {
            MyVariables.globalSoldier.apparent_age_months_att = Att2AgeMonth.text
            totalPost += "&apparent_age_months_att=" + MyVariables.globalSoldier.apparent_age_months_att
        }
        if (Att2Reilgion.text != "") {
            MyVariables.globalSoldier.religion = Att2Reilgion.text
            totalPost += "&religion=" + MyVariables.globalSoldier.religion
        }
        if (Att2HeightFeet.text != "") {
            MyVariables.globalSoldier.height_feet_att = Att2HeightFeet.text
            totalPost += "&height_feet_att=" + MyVariables.globalSoldier.height_feet_att
        }
        if (Att2HeightInches.text != "") {
            MyVariables.globalSoldier.height_inches_att = Att2HeightInches.text
            totalPost += "&height_inches_att=" + MyVariables.globalSoldier.height_inches_att
        }
        if (Att2Weight.text != "") {
            MyVariables.globalSoldier.weight_att = Att2Weight.text
            totalPost += "&weight_att=" + MyVariables.globalSoldier.weight_att
        }
        if (Att2EyeColour.text != "") {
            MyVariables.globalSoldier.eye_colour_att = Att2EyeColour.text
            totalPost += "&eye_colour_att=" + MyVariables.globalSoldier.eye_colour_att
        }
        if (Att2Complexion.text != "") {
            MyVariables.globalSoldier.complexion_att = Att2Complexion.text
            totalPost += "&complexion_att=" + MyVariables.globalSoldier.complexion_att
        }
        if (Att2ChestFullEx.text != "") {
            MyVariables.globalSoldier.chest_full_expansion_att = Att2ChestFullEx.text
            totalPost += "&chest_full_expansion_att=" + MyVariables.globalSoldier.chest_full_expansion_att
        }
        if (Att2ChestROE.text != "") {
            MyVariables.globalSoldier.chest_range_of_expansion_att = Att2ChestROE.text
            totalPost += "&chest_range_of_expansion_att=" + MyVariables.globalSoldier.chest_range_of_expansion_att
        }
        if (Att2IdentifyingMarks.text != "") {
            MyVariables.globalSoldier.identifying_marks = Att2IdentifyingMarks.text
            totalPost += "&identifying_marks=" + MyVariables.globalSoldier.identifying_marks
        }
        if (Att2EthnicOrigin.text != "") {
            MyVariables.globalSoldier.ethnic_origin_att = Att2EthnicOrigin.text
            totalPost += "&ethnic_origin_att=" + MyVariables.globalSoldier.ethnic_origin_att
        }
        if (Att2HairColour.text != "") {
            MyVariables.globalSoldier.hair_colour_att = Att2HairColour.text
            totalPost += "&hair_colour_att=" + MyVariables.globalSoldier.hair_colour_att
        }
        if (Att2TradeorCalling.text != "") {
            MyVariables.globalSoldier.trade_or_calling = Att2TradeorCalling.text
            totalPost += "&trade_or_calling=" + MyVariables.globalSoldier.trade_or_calling
        }
        
        totalPost += "&table=Attestation3_Temp_WW1"
        
        //println(totalPost)
        
        // create the request & response
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
                //println(response)
                //println(data.description)
                
                // look at the response
                if let httpResponse = response as? NSHTTPURLResponse {
                    //println("HTTP response: \(httpResponse.description)")
                } else {
                    println("No HTTP response")
                }
                
        }
        
//        
//        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler:{ (response:NSURLResponse!, data: NSData!, error: NSError!) -> Void in
//            // look at the response
//            if let httpResponse = response as? NSHTTPURLResponse {
//                //println("HTTP response: \(httpResponse.description)")
//            } else {
//                println("No HTTP response")
//            }
//        })

        dispatch_async(dispatch_get_main_queue()) {
            self.performSegueWithIdentifier("Med1Segue", sender: self)
        }
    }
    override func viewDidLoad() {
    super.viewDidLoad()
        //println(MyVariables.globalSoldier.surname)
        Att2AgeMonth.text = MyVariables.globalSoldier.apparent_age_months_att
        Att2AgeYear.text = MyVariables.globalSoldier.apparent_age_years_att
        Att2ChestFullEx.text = MyVariables.globalSoldier.chest_full_expansion_att
        Att2ChestROE.text = MyVariables.globalSoldier.chest_range_of_expansion_att
        Att2Complexion.text = MyVariables.globalSoldier.complexion_att
        Att2EyeColour.text = MyVariables.globalSoldier.eye_colour_att
        Att2HeightFeet.text = MyVariables.globalSoldier.height_feet_att
        Att2HeightInches.text = MyVariables.globalSoldier.height_inches_att
        Att2IdentifyingMarks.text = MyVariables.globalSoldier.identifying_marks
        Att2Reilgion.text = MyVariables.globalSoldier.religion
        Att2Weight.text = MyVariables.globalSoldier.weight_att
        Att2EthnicOrigin.text = MyVariables.globalSoldier.ethnic_origin_att
        Att2HairColour.text = MyVariables.globalSoldier.hair_colour_att
        Att2TradeorCalling.text = MyVariables.globalSoldier.trade_or_calling
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    }
    
    
    
    

