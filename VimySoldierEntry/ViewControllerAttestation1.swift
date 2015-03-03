//
//  ViewControllerAttestation1.swift
//  VimySoldierEntry
//
//  Created by Mason Black on 2015-01-15.
//  Copyright (c) 2015 Mason Black. All rights reserved.
//

import UIKit

class ViewControllerAttestation1: UIViewController {

    @IBOutlet weak var lblDisplayName: UILabel!
    @IBOutlet weak var txtSurname: UITextField!
    @IBOutlet weak var txtChristianNames: UITextField!
    @IBOutlet weak var txtStreet: UITextField!
    @IBOutlet weak var txtTown: UITextField!
    @IBOutlet weak var txtProvince: UITextField!
    @IBOutlet weak var txtCountry: UITextField!
    @IBOutlet weak var txtPOBTown: UITextField!
    @IBOutlet weak var txtPOBCountry: UITextField!
    @IBOutlet weak var txtPOBProvince: UITextField!
    @IBOutlet weak var txtNOKName: UITextField!
    @IBOutlet weak var txtNOKAddress: UITextField!
    @IBOutlet weak var txtNOKRelationship: UITextField!
    @IBOutlet weak var btnSubmit: UIButton!
    
// *** Help File Descriptor 9
    @IBAction func btn_Click(sender: AnyObject) {
        
        var totalPost: String = ""
        
        //get the Access_Code and soldier_id from the last form
        if MyVariables.globalSoldier.soldier_id != "" {
            totalPost += "&soldier_id=" + MyVariables.globalSoldier.soldier_id
        }
        
        if MyVariables.access_code != "" {
            totalPost += "&access_code=" + MyVariables.access_code
        }
        
        // Make sure all of the UITextFields are not empty
        if (txtSurname.text != ""){
            MyVariables.globalSoldier.surname = txtSurname.text
            totalPost += "&surname=" + MyVariables.globalSoldier.surname
        }
        
        if (txtChristianNames.text != ""){
            MyVariables.globalSoldier.christian_names = txtChristianNames.text
            totalPost += "&christian_names=" + MyVariables.globalSoldier.christian_names
        }
        
        if (txtStreet.text != ""){
            MyVariables.globalSoldier.present_address_street = txtStreet.text
            totalPost += "&present_address_street=" + MyVariables.globalSoldier.present_address_street
        }
        
        if (txtTown.text != ""){
            MyVariables.globalSoldier.present_address_town = txtTown.text
            totalPost += "&present_address_town=" + MyVariables.globalSoldier.present_address_town
        }
        
        if (txtProvince.text != ""){
            MyVariables.globalSoldier.present_address_province = txtProvince.text
            totalPost += "&present_address_province=" + MyVariables.globalSoldier.present_address_province
        }
        
        if (txtCountry.text != ""){
            MyVariables.globalSoldier.present_address_country = txtCountry.text
            totalPost += "&present_address_country=" + MyVariables.globalSoldier.present_address_country
        }
        
        if (txtPOBTown.text != ""){
            MyVariables.globalSoldier.place_of_birth_town = txtPOBTown.text
            totalPost += "&place_of_birth_town=" + MyVariables.globalSoldier.place_of_birth_town
        }
        
        if (txtPOBProvince.text != ""){
            MyVariables.globalSoldier.place_of_birth_province = txtPOBProvince.text
            totalPost += "&place_of_birth_province=" + MyVariables.globalSoldier.place_of_birth_province
        }
        
        if (txtPOBCountry.text != ""){
            MyVariables.globalSoldier.place_of_birth_country = txtPOBCountry.text
            totalPost += "&place_of_birth_country=" + MyVariables.globalSoldier.place_of_birth_country
        }
        
        if (txtNOKName.text != ""){
            MyVariables.globalSoldier.name_next_of_kin = txtNOKName.text
            totalPost += "&name_next_of_kin=" + MyVariables.globalSoldier.name_next_of_kin
        }
        
        if (txtNOKAddress.text != ""){
            MyVariables.globalSoldier.address_next_of_kin = txtNOKAddress.text
            totalPost += "&address_next_of_kin=" + MyVariables.globalSoldier.address_next_of_kin
        }
        
        if (txtNOKRelationship.text != ""){
            MyVariables.globalSoldier.relationship_to_next_of_kin = txtNOKRelationship.text
            totalPost += "&relationship_to_next_of_kin=" + MyVariables.globalSoldier.relationship_to_next_of_kin
        }
        
        totalPost += "&table=Attestation1_Temp_WW1"
        
        //println(totalPost)
        
        // create the request & response
        
        //var request = NSMutableURLRequest(URL: NSURL(string: "http://requestb.in/yanvmlya")!, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData, timeoutInterval: 5)
        var request = NSMutableURLRequest(URL: NSURL(string: "http://www.lest-we-forget.ca/dataentry/ww1_mobile_edit_soldier.php")!, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData, timeoutInterval: 5)
        var response: NSURLResponse?
        var error: NSError?
        var jsonStr = MyVariables.globalSoldier.makeJSON()
        var err: NSError?

// *** Help File Descriptor 10
        request.HTTPMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        // Take all of the information stored in totalPost and format it so that it can be sent to the server
        request.HTTPBody = totalPost.dataUsingEncoding(NSUTF8StringEncoding);

        // Send an asynchronous request to get the information from the api
//        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler:{ (response:NSURLResponse!, data: NSData!, error: NSError!) -> Void in
//            var error: AutoreleasingUnsafeMutablePointer<NSError?> = nil
//            
//            // look at the response
//            if let httpResponse = response as? NSHTTPURLResponse {
//                println("HTTP response: \(httpResponse.description)")
//            } else {
//                println("No HTTP response")
//            }
//            println("hey")
//        })
        
        
// *** Help File Descriptor 11
        // Send the request to the server
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue())
        {
            (response, data, error) in
            //println(response)
            println(data.description)
            
            // look at the response
            if let httpResponse = response as? NSHTTPURLResponse {
                println("HTTP response: \(httpResponse.description)")
            } else {
                println("No HTTP response")
            }
            
        }
        
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler:{ (response:NSURLResponse!, data: NSData!, error: NSError!) -> Void in
                // look at the response
                if let httpResponse = response as? NSHTTPURLResponse {
                    println("HTTP response: \(httpResponse.description)")
                } else {
                    println("No HTTP response")
                }
        })
    }
    

    
// *** Help File Descriptor 8 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Place all of the soldier's fields inside the appropriate UITextFields
        //lblDisplayName.text = MyVariables.globalSoldier.surname
        println(MyVariables.globalSoldier.surname)
        txtSurname.text = MyVariables.globalSoldier.surname
        txtChristianNames.text = MyVariables.globalSoldier.christian_names
        txtStreet.text = MyVariables.globalSoldier.present_address_street
        txtTown.text = MyVariables.globalSoldier.present_address_town
        txtProvince.text = MyVariables.globalSoldier.present_address_province
        txtCountry.text = MyVariables.globalSoldier.present_address_country
        txtPOBTown.text = MyVariables.globalSoldier.place_of_birth_town
        txtPOBProvince.text = MyVariables.globalSoldier.place_of_birth_province
        txtPOBCountry.text = MyVariables.globalSoldier.place_of_birth_country
        txtNOKName.text = MyVariables.globalSoldier.name_next_of_kin
        txtNOKAddress.text = MyVariables.globalSoldier.address_next_of_kin
        txtNOKRelationship.text = MyVariables.globalSoldier.relationship_to_next_of_kin
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
