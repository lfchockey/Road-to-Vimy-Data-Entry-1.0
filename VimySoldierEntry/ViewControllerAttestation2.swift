//
//  ViewControllerAttestation2.swift
//  VimySoldierEntry
//
//  Created by Student on 2015-06-09.
//  Copyright (c) 2015 Mason Black. All rights reserved.
//

import Foundation
import UIKit

class ViewControllerAttestation2: UIViewController {
    
    @IBOutlet weak var SegMartial: UISegmentedControl!
    @IBOutlet weak var SegVaccinated: UISegmentedControl!
    @IBOutlet weak var SegMilita: UISegmentedControl!
    @IBOutlet weak var SegMilitary: UISegmentedControl!
    @IBOutlet weak var txtParticulars: UITextField!
    @IBOutlet weak var SegEnagement: UISegmentedControl!
    @IBOutlet weak var SegCOEF: UISegmentedControl!
    @IBOutlet weak var txtDependants: UITextField!
    @IBOutlet weak var txtConscription: UITextField!
    @IBOutlet weak var btnSubmit: UIButton!
    
    //@IBOutlet weak var txtEnlist: UILabel!
    @IBOutlet weak var enlistDatePicker: UIDatePicker!
    
    @IBAction func dateChosen(sender: AnyObject) {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        var strDate = dateFormatter.stringFromDate(enlistDatePicker.date)
        
        MyVariables.globalSoldier.date_of_enlistment_conscription = strDate
        //txtEnlist.text = strDate
    }
    
    
    @IBAction func maritalSegment(sender: AnyObject) {
        
        var SelectedChoice1 = 0
        
        switch SegMartial.selectedSegmentIndex {
        case 0:
            MyVariables.globalSoldier.marital_status = "married"
            SelectedChoice1 = SegMartial.selectedSegmentIndex
        case 1:
            MyVariables.globalSoldier.marital_status = "widowed"
            SelectedChoice1 = SegMartial.selectedSegmentIndex
        case 2:
            MyVariables.globalSoldier.marital_status = "single"
            SelectedChoice1 = SegMartial.selectedSegmentIndex
        case 3:
            MyVariables.globalSoldier.marital_status = "not sure"
        default:
            break;
        }
    }
    
    @IBAction func vaccinatedSegment(sender: AnyObject) {
        var SelectedChoice2 = 0
        
        switch SegVaccinated.selectedSegmentIndex {
        case 0:
            MyVariables.globalSoldier.vaccination_willingness = "yes"
            SelectedChoice2 = SegVaccinated.selectedSegmentIndex
        case 1:
            MyVariables.globalSoldier.vaccination_willingness = "no"
            SelectedChoice2 = SegVaccinated.selectedSegmentIndex
        case 2:
            MyVariables.globalSoldier.vaccination_willingness = "not sure"
            SelectedChoice2 = SegVaccinated.selectedSegmentIndex
        default:
            break;
        }
    }
    
    @IBAction func militaSegment(sender: AnyObject) {
        var SelectedChoice3 = 0
        
        switch SegMilita.selectedSegmentIndex {
        case 0:
            MyVariables.globalSoldier.active_militia = "yes"
            SelectedChoice3 = SegMilita.selectedSegmentIndex
        case 1:
            MyVariables.globalSoldier.active_militia = "no"
            SelectedChoice3 = SegMilita.selectedSegmentIndex
        case 2:
            MyVariables.globalSoldier.active_militia = "not sure"
            SelectedChoice3 = SegMilita.selectedSegmentIndex
        default:
            break;
        }
    }
    
    @IBAction func militarySegment(sender: AnyObject) {
        var SelectedChoice4 = 0
        
        switch SegMilitary.selectedSegmentIndex {
        case 0:
            MyVariables.globalSoldier.served_in_military_force = "yes"
            SelectedChoice4 = SegMilitary.selectedSegmentIndex
        case 1:
            MyVariables.globalSoldier.served_in_military_force = "no"
            SelectedChoice4 = SegMilitary.selectedSegmentIndex
        case 2:
            MyVariables.globalSoldier.served_in_military_force = "not sure"
            SelectedChoice4 = SegMilitary.selectedSegmentIndex
        default:
            break;
        }
    }
    
    @IBAction func enagementSegment(sender: AnyObject) {
        var SelectedChoice5 = 0
        
        switch SegEnagement.selectedSegmentIndex {
        case 0:
            MyVariables.globalSoldier.engagement_understanding = "yes"
            SelectedChoice5 = SegEnagement.selectedSegmentIndex
        case 1:
            MyVariables.globalSoldier.engagement_understanding = "no"
            SelectedChoice5 = SegEnagement.selectedSegmentIndex
        case 2:
            MyVariables.globalSoldier.engagement_understanding = "not sure"
            SelectedChoice5 = SegEnagement.selectedSegmentIndex
        default:
            break;
        }
    }
    
    @IBAction func coefSegment(sender: AnyObject) {
        var SelectedChoice6 = 0
        
        switch SegCOEF.selectedSegmentIndex {
        case 0:
            MyVariables.globalSoldier.attestation_willingness = "yes"
            SelectedChoice6 = SegCOEF.selectedSegmentIndex
        case 1:
            MyVariables.globalSoldier.attestation_willingness = "no"
            SelectedChoice6 = SegCOEF.selectedSegmentIndex
        case 2:
            MyVariables.globalSoldier.attestation_willingness = "not sure"
            SelectedChoice6 = SegCOEF.selectedSegmentIndex
        default:
            break;
        }
    }
    
    @IBAction func btn_Click(sender: AnyObject) {
        
        var totalPost: String = ""
        
        //get the Access_Code and soldier_id from the last form
        if MyVariables.globalSoldier.soldier_id != "" {
            totalPost += "&soldier_id=" + MyVariables.globalSoldier.soldier_id
        }
        
        if MyVariables.access_code != "" {
            totalPost += "&access_code=" + MyVariables.access_code
        }
        
        totalPost += "&marital_status=" + MyVariables.globalSoldier.marital_status
        totalPost += "&vaccination_willingness=" + MyVariables.globalSoldier.vaccination_willingness
        totalPost += "&active_militia=" + MyVariables.globalSoldier.active_militia
        totalPost += "&served_in_military_force=" + MyVariables.globalSoldier.served_in_military_force
        totalPost += "&engagement_understanding=" + MyVariables.globalSoldier.engagement_understanding
        totalPost += "&attestation_willingness=" + MyVariables.globalSoldier.attestation_willingness
        
        if (txtParticulars.text != "")
        {
            MyVariables.globalSoldier.military_force_particulars = txtParticulars.text
            totalPost += "&military_force_particulars=" + MyVariables.globalSoldier.military_force_particulars
        }
        
        if (txtDependants.text != "")
        {
            MyVariables.globalSoldier.number_of_dependants = txtDependants.text
            totalPost += "&number_of_dependants=" + MyVariables.globalSoldier.number_of_dependants
        }
        
        if (txtConscription.text != "")
        {
            MyVariables.globalSoldier.place_of_enlistment = txtConscription.text
            totalPost += "&place_of_enlistment=" + MyVariables.globalSoldier.place_of_enlistment
        }
        
        if MyVariables.globalSoldier.date_of_enlistment_conscription != "" {
            totalPost += "&date_of_enlistment_conscription=" + MyVariables.globalSoldier.date_of_enlistment_conscription
        }
        
        totalPost += "&table=Attestation2_Temp_WW1"
        
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
            self.performSegueWithIdentifier("Att3Segue", sender: self)
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        var testDate = "1884-02-19"
        
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let dateOfEnlistConscript = dateFormatter.dateFromString(MyVariables.globalSoldier.date_of_enlistment_conscription) {
            enlistDatePicker.date = dateOfEnlistConscript
        }
        else {
            let newDate = dateFormatter.dateFromString("1888-08-08")
        }
        
        switch MyVariables.globalSoldier.marital_status {
        case "married":
            SegMartial.selectedSegmentIndex = 0
        case "widowed":
            SegMartial.selectedSegmentIndex = 1
        case "single":
            SegMartial.selectedSegmentIndex = 2
        case "not sure":
            SegMartial.selectedSegmentIndex = 3
        default:
            SegMartial.selectedSegmentIndex = 3
        }
        
        switch MyVariables.globalSoldier.vaccination_willingness {
        case "yes":
            SegVaccinated.selectedSegmentIndex = 0
        case "no":
            SegVaccinated.selectedSegmentIndex = 1
        case "not sure":
            SegVaccinated.selectedSegmentIndex = 2
        default:
            SegVaccinated.selectedSegmentIndex = 2
        }
        
        switch MyVariables.globalSoldier.active_militia {
        case "yes":
            SegMilita.selectedSegmentIndex = 0
        case "no":
            SegMilita.selectedSegmentIndex = 1
        case "not sure":
            SegMilita.selectedSegmentIndex = 2
        default:
            SegMilita.selectedSegmentIndex = 2
        }
        
        switch MyVariables.globalSoldier.served_in_military_force {
        case "yes":
            SegMilitary.selectedSegmentIndex = 0
        case "no":
            SegMilitary.selectedSegmentIndex = 1
        case "not sure":
            SegMilitary.selectedSegmentIndex = 2
        default:
            SegMilitary.selectedSegmentIndex = 2
        }
        
        switch MyVariables.globalSoldier.engagement_understanding {
        case "yes":
            SegEnagement.selectedSegmentIndex = 0
        case "no":
            SegEnagement.selectedSegmentIndex = 1
        case "not sure":
            SegEnagement.selectedSegmentIndex = 2
        default:
            SegEnagement.selectedSegmentIndex = 2
        }
        
        switch MyVariables.globalSoldier.attestation_willingness {
        case "yes":
            SegCOEF.selectedSegmentIndex = 0
        case "no":
            SegCOEF.selectedSegmentIndex = 1
        case "not sure":
            SegCOEF.selectedSegmentIndex = 2
        default:
            SegCOEF.selectedSegmentIndex = 2
        }
        
        txtConscription.text = MyVariables.globalSoldier.place_of_enlistment
        txtDependants.text = MyVariables.globalSoldier.number_of_dependants
        txtParticulars.text = MyVariables.globalSoldier.military_force_particulars
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}