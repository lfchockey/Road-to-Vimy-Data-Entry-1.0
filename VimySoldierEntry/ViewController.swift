//
//  ViewController.swift
//  VimySoldierEntry
//
//  Created by Mason Black on 2014-12-30.
//  Copyright (c) 2014 Mason Black. All rights reserved.
//

import UIKit

// Structs are useful to define global variables that can be accessed anywhere inside the current module
struct MyVariables {
    static var globalSoldier:FullSoldier = FullSoldier()
    static var access_code: String = ""
}



class ViewController: UIViewController {


    
    @IBOutlet weak var txtAccessCode: UITextField!
    @IBOutlet weak var txtChristianNames: UITextField!
    @IBOutlet weak var txtSurname: UITextField!
    @IBOutlet weak var txtRegimentalNumber: UITextField!
    @IBOutlet weak var submitSoldierButton: UIButton!

    
    @IBOutlet weak var switchOfficer: UISwitch!
    @IBOutlet weak var txtOfficerRank: UITextField!
    
    var vCA1: ViewControllerAttestation1?

    @IBAction func officerChange(sender: AnyObject) {
       
        if switchOfficer.on // This means 'Yes' was selected.
        {
            txtOfficerRank.hidden = false    // show the textField to enter officer's rank.
        }
        else // 'No' was selected.
        {
            txtOfficerRank.hidden = true    // hide the textfield to enter officer's rank.
        }
        
    }
 
// *** Help File Descriptor 1
    @IBAction func submitSoldierClick(sender: AnyObject) {
        var schoolAccessCode: String
        var christianNames: String
        var surname: String
        var regimentalNumber: String
        var officerRank: String
        
        // save the information from the textFields in the local variables
        schoolAccessCode = txtAccessCode.text
        MyVariables.access_code = txtAccessCode.text
        christianNames = txtChristianNames.text
        surname = txtSurname.text
        regimentalNumber = txtRegimentalNumber.text
        officerRank = txtOfficerRank.text
        
        
        
        // check to see if any of the textFields were left blank. All fields are required.
        if (schoolAccessCode == "" || christianNames == "" || surname == "" || regimentalNumber == "") {
            
//            var iosVer8: Bool = false
//            var alert = UIAlertController()
//            var alert2 = UIAlertView()
            
//            // create an alert controller (pop up)
//            if objc_getClass("UIAlertController") != nil {
//                iosVer8 = true
//                println("UIAlertController can be instantiated")
//                
//                //make and use a UIAlertController
//                alert = UIAlertController(title: "Update Information", message: "You must fill in all information completely", preferredStyle: UIAlertControllerStyle.Alert)
//                alert.addAction(UIAlertAction(title: "Update Information", style: UIAlertActionStyle.Default, handler: nil))
//            }
//            else {
//                iosVer8 = false
//                println("UIAlertController can NOT be instantiated")
//                
//                //make and use a UIAlertView
//                //var alert2 = UIAlertView()
//                alert2.title = "Alert"
//                alert2.message = "Here's a message"
//                alert2.addButtonWithTitle("Understood")
//            }
            
            
            // check to see if officer's rank was entered
            if (switchOfficer.on && (txtOfficerRank.text == "" || txtOfficerRank.text == "Enter Rank")) {
//                if (iosVer8) {
//                    alert.message = "Please enter the officer's rank and any other incomplete information"
//                    //self.presentViewController(alert, animated: true, completion: nil)
//                }
//                else {
//                    alert2.message = "Please enter the officer's rank and any other incomplete information"
//                }
                showErrorMessage("Please enter the officer's rank and any other incomplete information")
            }
            else {
                showErrorMessage("You must fill in all information completely")
            }
            
//            if (iosVer8){
//                // display the 'alert' popup
//                self.presentViewController(alert, animated: true, completion: nil)
//            }
//            else {
//                alert2.show()
//            }
            

//            alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { action in
//                switch action.style{
//                case .Default:
//                    println("default")
//
//                case .Cancel:
//                    println("cancel")
//
//                case .Destructive:
//                    println("destructive")
//                }
//            }))
        }
        else { // All info is entered, so submit the soldier information to the API
            var isOfficer: Bool = switchOfficer.on
            if !isOfficer {
                officerRank = ""
            }
            //var url : String = "http://lest-we-forget.ca/apis/redirect_ww1_mobile.php?type=add_soldier&access_code=SFDCI_Black&officer=rank=&surname=Black&christian_names=Mason&soldier_id=55"
            var url : String = "http://lest-we-forget.ca/apis/redirect_ww1_mobile.php?type=add_soldier&access_code=SFDCI_Black&officer=\(isOfficer)&rank=\(officerRank)&surname=\(surname)&christian_names=\(christianNames)&soldier_id=\(regimentalNumber)"

// *** Help File Descriptor 2
            // Build the URL request with the URL above
            var request : NSMutableURLRequest = NSMutableURLRequest()
            request.URL = NSURL(string: url)
            request.HTTPMethod = "GET"  // This defines how the information will be passed to the API website
            
// *** Help File Descriptor 3
            // Send an asynchronous request to get the information from the API
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler:{ (response:NSURLResponse!, data: NSData!, error: NSError!) -> Void in
                var error: AutoreleasingUnsafeMutablePointer<NSError?> = nil
                let jsonResult: NSDictionary! = NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions.MutableContainers, error: error) as? NSDictionary
                //println(jsonResult)
// *** Help File Descriptor 4
                if (jsonResult != nil) {
                    // Navigate to a new page passing the parameters along
                    //      get the values from the JSON passed back from the api
                    if let unwrappedJSONResult: AnyObject = jsonResult["result"] {
                        println(unwrappedJSONResult)
                        if (unwrappedJSONResult as! NSString == "Soldier Edit") {
                            // If the soldier was already entered into the database we need to set up 
                            //       and get the soldier info from the database so that we can use it later
                            if isOfficer {
                                println("The user tried to enter/edit an officer, but a soldier was sent back from the server")
                            }
                            else
                            {
// *** Help File Descriptor 5
                                MyVariables.globalSoldier = MyVariables.globalSoldier.assignSoldier(jsonResult)
                            }
                        }
                        else if (unwrappedJSONResult as! NSString == "Officer Edit"){
                            // Obtain the officer_id that was passed back after the API call
                            //      If soldier is an officer...
                            if isOfficer {
                                if let unwrappedJSONOfficerID: AnyObject = jsonResult["officer_id"] {
                                    MyVariables.globalSoldier.officer_id = unwrappedJSONOfficerID as! NSString as String
                                    
                                    // Obtain the soldier_id that was passed back after the API call
                                    if let unwrappedJSONSoldierID: AnyObject = jsonResult["soldier_id"]{
                                        MyVariables.globalSoldier.soldier_id = unwrappedJSONSoldierID as! NSString as String
                                    }
                                    else {
                                        println("Soldier ID not passed back properly from server")
                                        MyVariables.globalSoldier.soldier_id = "999" + MyVariables.globalSoldier.officer_id
                                    }
                                    MyVariables.globalSoldier = MyVariables.globalSoldier.assignSoldier(jsonResult)
                                }
                                else {
                                    // The officer_id wasn't passed back from the api (server)
//                                    if (iosVer8){
//                                        // display the 'alert' popup
//                                        self.alert.message = "There was a problem connecting to the Internet. Please try again later."
//                                        self.presentViewController(self.alert, animated: true, completion: nil)
//                                    }
//                                    else {
//                                        self.alert2.message = "There was a problem connecting to the Internet. Please try again later."
//                                        self.alert2.show()
//                                    }
                                    self.showErrorMessage("There was a problem connecting to the Internet. Please try again later.")
                                    println("Officer Id wasn't passed back from the server properly")
                                }
                            }
                            else {
                                println("The user tried to enter/edit a soldier, but an officer was sent back from the server")
                            }
                        }
                        else if (unwrappedJSONResult as! NSString == "Soldier Entry"){
                            if isOfficer {
                                println("The user tried to enter/edit an officer, but a soldier was sent back from the server")
                            }
                            else    // Enter the soldier for the first time
                            {
                                MyVariables.globalSoldier.soldier_id = regimentalNumber
                                MyVariables.globalSoldier.surname = surname
                                MyVariables.globalSoldier.christian_names = christianNames
                                MyVariables.globalSoldier.officer_id = regimentalNumber
                            }
                        }
                        else if (unwrappedJSONResult as! NSString == "Officer Entry"){
                            if isOfficer {
                                if let unwrappedJSONOfficerID: AnyObject = jsonResult["officer_id"] {
                                    MyVariables.globalSoldier.officer_id = unwrappedJSONOfficerID as! NSString as String
                                    
                                    // Obtain the soldier_id that was passed back after the API call
                                    if let unwrappedJSONSoldierID: AnyObject = jsonResult["soldier_id"]{
                                        MyVariables.globalSoldier.soldier_id = unwrappedJSONSoldierID as! NSString as String
                                    }
                                    else {
                                        println("Soldier Id not passed back properly from server")
                                        MyVariables.globalSoldier.soldier_id = "999" + MyVariables.globalSoldier.officer_id
                                    }
                                    MyVariables.globalSoldier.surname = surname
                                    MyVariables.globalSoldier.christian_names = christianNames
                                    MyVariables.globalSoldier.officer_id = regimentalNumber
                                }
                                else {
                                    // The officer_id wasn't passed back from the api (server)
//                                    if (iosVer8){
//                                        self.alert.message = "There was a problem connecting to the Internet. Please try again later."
//                                        // display the 'alert' popup
//                                        self.presentViewController(self.alert, animated: true, completion: nil)
//                                    }
//                                    else {
//                                        self.alert2.message = "There was a problem connecting to the Internet. Please try again later."
//                                        self.alert2.show()
//                                    }
                                    self.showErrorMessage("There was a problem connecting to the Internet. Please try again later.")
                                    println("Officer Id wasn't passed back from the server properly")
                                }
                            }
                            else    // Enter the soldier for the first time
                            {
                                println("The user tried to enter/edit an officer, but a soldier was sent back from the server")
                            }
                        }
                        else {
//                            if (iosVer8){
//                                self.alert.message = "There was a problem connecting to the Internet. Please try again later."
//                                // display the 'alert' popup
//                                self.presentViewController(self.alert, animated: true, completion: nil)
//                            }
//                            else {
//                                self.alert2.message = "There was a problem connecting to the Internet. Please try again later."
//                                self.alert2.show()
                            
//                        }
                            self.showErrorMessage("There was a problem connecting to the Internet. Please try again later.")
                            println("Unkown value passed back from the server")
                            
                        }
// *** Help File Descriptor 6
                        // Navigate to the first AttestionViewController
                        //      This must be done within the main queue
                        dispatch_async(dispatch_get_main_queue()) {
                            self.performSegueWithIdentifier("Att1Segue", sender: self)
                        }
                    }
                }
                else {
                    // couldn't load JSON, look at error
                    println("couldn't load JSON \(error)")
                }
                
                
            })
        }

    }
    
    func showErrorMessage(message: String) {

                // create an alert controller (pop up)
        if objc_getClass("UIAlertController") != nil {

            println("UIAlertController can be instantiated")
            
            //make and use a UIAlertController
            var alert = UIAlertController(title: "Update Information", message: message, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Update Information", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else {
            
            println("UIAlertController can NOT be instantiated")
            
            //make and use a UIAlertView
            var alert2 = UIAlertView()
            alert2.title = "Alert"
            alert2.message = message
            alert2.addButtonWithTitle("Understood")
            alert2.show()
        }

    }

// *** Help File Descriptor 7
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //vCA1 = segue.destinationViewController as? ViewControllerAttestation1
        // The app doesn't use this technique to connect to another UIView
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //self.view.backgroundColor = UIColor(red: 194.0/255.0, green: 178.0/255.0, blue: 128.0/255.0, alpha: 1.0)
        
        
        txtOfficerRank.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

