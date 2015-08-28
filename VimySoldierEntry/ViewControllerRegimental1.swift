//
//  ViewControllerRegimental1.swift
//  VimySoldierEntry
//
//  Created by Student on 2015-05-13.
//  Copyright (c) 2015 Mason Black. All rights reserved.
//

import Foundation
import UIKit

class ViewControllerRegimental1: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var switchService: UISwitch! //Enlisted or Conscripted
    @IBOutlet weak var txtQualifications: UITextField! //Soldier's Qualifications
    @IBOutlet weak var txtRankEnlist: UITextField! //Rank Upon Enlistment
    @IBOutlet weak var txtHighestRank: UITextField! //Highest Rank Achieved
    @IBOutlet weak var txtBattalionDB: UITextField! //Battalion Upon Enlistment
    @IBOutlet weak var autoCompleteTableView: UITableView! //BattalionDB Search Bar
    @IBOutlet weak var militaryType: UISegmentedControl! //Military Force Multiple Choice
    @IBOutlet weak var txtSquadron: UITextField! //Unit_Squadron_Ship
    @IBOutlet weak var txtBattalion: UITextField! //Battalion_Brigade_Division
    @IBOutlet weak var autoCompleteTableView2: UITableView! //Battalion Text Search Bar
    @IBOutlet weak var txtCompany: UITextField! //Company
    @IBOutlet weak var btnSubmitRegimental1Info: UIButton! //Submit Button
    
    var autocompleteRegiment = [String]()
    var isBattalionDBFocused = false
    var isBattalionTextFocused = false

    @IBAction func DropBoxChoice1(sender: AnyObject) {
        
        isBattalionTextFocused = false
        isBattalionDBFocused = true
    }
    
    @IBAction func DropBoxChoice2(sender: AnyObject) {
        
        isBattalionTextFocused = true
        isBattalionDBFocused = false
    }
    
    @IBAction func selectedSegment(sender: UISegmentedControl) {
        
        var SelectedChoice = 0
        
        switch militaryType.selectedSegmentIndex {
        case 0:
            MyVariables.globalSoldier.military_force = "army"
            SelectedChoice = militaryType.selectedSegmentIndex
        case 1:
            MyVariables.globalSoldier.military_force = "navy"
            SelectedChoice = militaryType.selectedSegmentIndex
        case 2:
            MyVariables.globalSoldier.military_force = "rcaf"
            SelectedChoice = militaryType.selectedSegmentIndex
        case 3:
            MyVariables.globalSoldier.military_force = "medic"
            SelectedChoice = militaryType.selectedSegmentIndex
        case 4:
            MyVariables.globalSoldier.military_force = "other"
            SelectedChoice = militaryType.selectedSegmentIndex
        case 5:
            MyVariables.globalSoldier.military_force = "not sure"
            SelectedChoice = militaryType.selectedSegmentIndex
        default:
            break;
            
        }
    }
    
    @IBAction func btn_Click(sender: AnyObject) {
        
        var totalPost: String = ""
        if MyVariables.globalSoldier.soldier_id != "" {
            totalPost += "&soldier_id=" + MyVariables.globalSoldier.soldier_id
        }
        
        if MyVariables.access_code != "" {
            totalPost += "&access_code=" + MyVariables.access_code
        }
        
        //Military Type Segment Control
        totalPost += "&military_force=" + MyVariables.globalSoldier.military_force
        
        //Qualification Text
        if (txtQualifications.text != "")
        {
            MyVariables.globalSoldier.qualification = txtQualifications.text
            totalPost += "&qualification=" + MyVariables.globalSoldier.qualification
        }
        
        //Rank Enlistment Text
        if (txtRankEnlist.text != "")
        {
            MyVariables.globalSoldier.rank_upon_enlistment = txtRankEnlist.text
            totalPost += "&rank_upon_enlistment=" + MyVariables.globalSoldier.rank_upon_enlistment
        }
        
        //Highest Achieved Rank Text
        if (txtHighestRank.text != "")
        {
            MyVariables.globalSoldier.rank_highest_achieved = txtHighestRank.text
            totalPost += "&rank_highest_achieved=" + MyVariables.globalSoldier.rank_highest_achieved
        }
        
        //Batallion Drop Box Text
        if (txtBattalionDB.text != "")
        {
            MyVariables.globalSoldier.regiment_upon_enlistment = txtBattalionDB.text
            totalPost += "&regiment_upon_enlistment=" + MyVariables.globalSoldier.regiment_upon_enlistment
        }
        
        //Squadron/Unit/Ship Text
        if (txtSquadron.text != "")
        {
            MyVariables.globalSoldier.unit_ship_squadron = txtSquadron.text
            totalPost += "&unit_ship_squadron=" + MyVariables.globalSoldier.unit_ship_squadron
        }
        
        //Battalion/Brigade/Division Text
        if (txtBattalion.text != "")
        {
            MyVariables.globalSoldier.battalion = txtBattalion.text
            totalPost += "&battalion=" + MyVariables.globalSoldier.battalion
        }
        
        //Company Text
        if (txtCompany.text != "")
        {
            MyVariables.globalSoldier.company = txtCompany.text
            totalPost += "&company=" + MyVariables.globalSoldier.company
        }
        
        //Enlist or Conscript Switch
        if (switchService.on)
        {
            MyVariables.globalSoldier.conscription = "Conscripted"
            totalPost += "&conscription=" + MyVariables.globalSoldier.conscription
        }
        else
        {
            MyVariables.globalSoldier.conscription = "Enlisted"
            totalPost += "&conscription=" + MyVariables.globalSoldier.conscription
        }
        
        totalPost += "&table=Regimental1_Temp_WW1"
        
        //println(totalPost)
        
        var request = NSMutableURLRequest(URL: NSURL(string: "http://www.lest-we-forget.ca/apis/ww1_mobile_edit_soldier_api.php")!, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData, timeoutInterval: 5)
        var response: NSURLResponse?
        var error: NSError?
        var jsonStr = MyVariables.globalSoldier.makeJSON()
        var err: NSError?
        
        request.HTTPMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = totalPost.dataUsingEncoding(NSUTF8StringEncoding);
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue())
        {
            (response, data, error) in
            // look at the response
            if let httpResponse = response as? NSHTTPURLResponse {
                //println("HTTP response: \(httpResponse.description)")
            }
            else {
                println("No HTTP response")
            }
        }
        
//        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler:{ (response:NSURLResponse!, data: NSData!, error: NSError!) -> Void in
//            // look at the response
//            if let httpResponse = response as? NSHTTPURLResponse {
//                //println("HTTP response: \(httpResponse.description)")
//            }
//            else {
//                println("No HTTP response")
//            }
//        })
        
       dispatch_async(dispatch_get_main_queue()) {
           self.performSegueWithIdentifier("Reg2Segue", sender: self)
       }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch MyVariables.globalSoldier.military_force {
        case "army":
            militaryType.selectedSegmentIndex = 0
        case "navy":
            militaryType.selectedSegmentIndex = 1
        case "rcaf":
            militaryType.selectedSegmentIndex = 2
        case "medic":
            militaryType.selectedSegmentIndex = 3
        case "other":
            militaryType.selectedSegmentIndex = 4
        case "not sure":
            militaryType.selectedSegmentIndex = 5
        default:
            militaryType.selectedSegmentIndex = 5
        }
        
        //println(MyVariables.globalSoldier.conscription)
        txtQualifications.text = MyVariables.globalSoldier.qualification
        txtRankEnlist.text = MyVariables.globalSoldier.rank_upon_enlistment
        txtHighestRank.text = MyVariables.globalSoldier.rank_highest_achieved
        txtBattalionDB.text = MyVariables.globalSoldier.regiment_upon_enlistment
        txtSquadron.text = MyVariables.globalSoldier.unit_ship_squadron
        txtBattalion.text = MyVariables.globalSoldier.battalion
        txtCompany.text = MyVariables.globalSoldier.company
        
        if (MyVariables.globalSoldier.conscription.lowercaseString == "conscripted")
        {
            switchService.on = true
        }
        if (MyVariables.globalSoldier.conscription.lowercaseString == "enlisted")
        {
            switchService.on = false
        }
        txtBattalionDB.delegate = self
        txtBattalion.delegate = self
        
        autoCompleteTableView!.delegate = self
        autoCompleteTableView!.dataSource = self
        autoCompleteTableView!.scrollEnabled = true
        autoCompleteTableView!.hidden = true
        
        autoCompleteTableView2!.delegate = self
        autoCompleteTableView2!.dataSource = self
        autoCompleteTableView2!.scrollEnabled = true
        autoCompleteTableView2!.hidden = true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool
    {
        if (isBattalionDBFocused == true)
        {
            autoCompleteTableView!.hidden = false
            var substring = (self.txtBattalionDB.text as NSString).stringByReplacingCharactersInRange(range, withString: string)
            
            searchAutocompleteEntriesWithSubstring(substring)
        }
        else if (isBattalionTextFocused == true)
        {
            autoCompleteTableView2!.hidden = false
            var substring2 = (self.txtBattalion.text as NSString).stringByReplacingCharactersInRange(range, withString: string)
            
            searchAutocompleteEntriesWithSubstring(substring2)
        }
        return true
    }

    func searchAutocompleteEntriesWithSubstring(substring: String)
    {
        var lCaseSubString = substring.lowercaseString
        autocompleteRegiment.removeAll(keepCapacity: false)
        //println(substring)
        
        for curString in battalions
        {
            //println(curString)
            var lCaseCurString = curString.lowercaseString
            var lCaseMyString: NSString! = lCaseCurString as NSString
            var lCaseSubstringRange: NSRange! = lCaseMyString.rangeOfString(lCaseSubString)
            if lCaseCurString.rangeOfString(lCaseSubString) != nil {
                autocompleteRegiment.append(curString)
            }
            
        }
        if (isBattalionDBFocused == true)
        {
            autoCompleteTableView!.reloadData()
        }
        else if (isBattalionTextFocused == true)
        {
            autoCompleteTableView2!.reloadData()
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return autocompleteRegiment.count
    }
    
    // loads all information into TableView
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let autoCompleteRowIdentifier = "AutoCompleteRowIdentifier"
        var cell = tableView.dequeueReusableCellWithIdentifier(autoCompleteRowIdentifier) as? UITableViewCell
        
        
        
        if let tempo1 = cell
        {
            let index = indexPath.row as Int
            cell!.textLabel!.text = autocompleteRegiment[index]
            cell!.textLabel!.adjustsFontSizeToFitWidth = true
            cell!.textLabel!.minimumScaleFactor = 0.1
            cell!.textLabel!.font = UIFont.systemFontOfSize(12.0)
        } else
        {
            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: autoCompleteRowIdentifier)
        }
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedCell : UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        if (isBattalionDBFocused == true)
        {
            txtBattalionDB.text = selectedCell.textLabel!.text
        }
        else if (isBattalionTextFocused == true)
        {
            txtBattalion.text = selectedCell.textLabel!.text
        }
        autoCompleteTableView!.hidden = true
        autoCompleteTableView2!.hidden = true
    }
    
    var battalions = [
        "1st Field Battery - 1st Brigade C.F.A. - 1st Division",
        "3rd Field Battery - 1st Brigade C.F.A. - 1st Division",
        "4th Field Battery - 1st Brigade C.F.A. - 1st Division",
        "5th Field Battery - 2nd Brigade C.F.A. - 1st Division",
        "6th Field Battery - 2nd Brigade C.F.A. - 1st Division",
        "7th Field Battery - 2nd Brigade C.F.A. - 1st Division",
        "10th Field Battery - 3rd Brigade C.F.A. - 4th Division",
        "11th Field Battery - 3rd Brigade C.F.A. - 4th Division",
        "12th Field Battery - 3rd Brigade C.F.A. - 4th Division",
        "13th Field Battery - 4th Brigade C.F.A. - 4th Division",
        "15th Field Battery - 6th Brigade C.F.A. - 2nd Division",
        "16th Field Battery - 6th Brigade C.F.A. - 2nd Division",
        "17th Field Battery - 5th Brigade C.F.A. - 2nd Division",
        "18th Field Battery - 5th Brigade C.F.A. - 2nd Division",
        "19th Field Battery - 4th Brigade C.F.A. - 4th Division",
        "20th Field Battery - 5th Brigade C.F.A. - 2nd Division",
        "25th Field Battery - 6th Brigade C.F.A. - 2nd Division",
        "27th Field Battery - 4th Brigade C.F.A. - 4th Division",
        "31st Field Battery - 9th Brigade C.F.A. - 3rd Division",
        "33rd Field Battery - 9th Brigade C.F.A. - 3rd Division",
        "38th Field Battery - 10th Brigade C.F.A. - 3rd Division",
        "39th Field Battery - 10th Brigade C.F.A. - 3rd Division",
        "40th Field Battery - 10th Brigade C.F.A. - 3rd Division",
        "45th Field Battery - 9th Brigade C.F.A. - 3rd Division",
        "1st Battalion - 1st Infantry Brigade - 1st Division",
        "2nd Battalion - 1st Infantry Brigade - 1st Division",
        "3rd Battalion - 1st Infantry Brigade - 1st Division",
        "4th Battalion - 1st Infantry Brigade - 1st Division",
        "5th Battalion - 2nd Infantry Brigade - 1st Division",
        "7th Battalion - 2nd Infantry Brigade - 1st Division",
        "8th Battalion - 2nd Infantry Brigade - 1st Division",
        "10th Battalion - 2nd Infantry Brigade - 1st Division",
        "13th Battalion - 3rd Infantry Brigade - 1st Division",
        "14th Battalion - 3rd Infantry Brigade - 1st Division",
        "15th Battalion - 3rd Infantry Brigade - 1st Division",
        "16th Battalion - 3rd Infantry Brigade - 1st Division",
        "18th Battalion - 4th Infantry Brigade - 2nd Division",
        "19th Battalion - 4th Infantry Brigade - 2nd Division",
        "20th Battalion - 4th Infantry Brigade - 2nd Division",
        "21st Battalion - 4th Infantry Brigade - 2nd Division",
        "22nd Battalion - 5th Infantry Brigade - 2nd Division",
        "24th Battalion - 5th Infantry Brigade - 2nd Division",
        "25th Battalion - 5th Infantry Brigade - 2nd Division",
        "26th Battalion - 5th Infantry Brigade - 2nd Division",
        "27th Battalion - 6th Infantry Brigade - 2nd Division",
        "28th Battalion - 6th Infantry Brigade - 2nd Division",
        "29th Battalion - 6th Infantry Brigade - 2nd Division",
        "31st Battalion - 6th Infantry Brigade - 2nd Division",
        "38th Battalion - 12th Infantry Brigade - 4th Division",
        "42nd Battalion - 7th Infantry Brigade - 3rd Division",
        "43rd Battalion - 9th Infantry Brigade - 3rd Division",
        "44th Battalion - 10th Infantry Brigade - 4th Division",
        "46th Battalion - 10th Infantry Brigade - 4th Division",
        "47th Battalion - 10th Infantry Brigade - 4th Division",
        "49th Battalion - 7th Infantry Brigade - 3rd Division",
        "50th Battalion - 10th Infantry Brigade - 4th Division",
        "52nd Battalion - 9th Infantry Brigade - 3rd Division",
        "54th Battalion - 11th Infantry Brigade - 4th Division",
        "58th Battalion - 9th Infantry Brigade - 3rd Division",
        "72nd Battalion - 12th Infantry Brigade - 4th Division",
        "75th Battalion - 11th Infantry Brigade - 4th Division",
        "78th Battalion - 12th Infantry Brigade - 4th Division",
        "85th Battalion - 12th Infantry Brigade - 4th Division",
        "87th Battalion - 11th Infantry Brigade - 4th Division",
        "102nd Battalion - 11th Infantry Brigade - 4th Division",
        "116th Battalion - 9th Infantry Brigade - 3rd Division",
        "Royal Canadian Regiment - 7th Infantry Brigade - 3rd Division",
        "Princess Patricia's Canadian Light Infantry - 7th Infantry Brigade - 3rd Division",
        "1st Canadian Mounted Rifles Battalion - 8th Infantry Brigade - 3rd Division",
        "2nd Canadian Mounted Rifles Battalion - 8th Infantry Brigade - 3rd Division",
        "4th Canadian Mounted Rifles Battalion - 8th Infantry Brigade - 3rd Division",
        "5th Canadian Mounted Rifles Battalion - 8th Infantry Brigade - 3rd Division",
        "1st Trench Mortar Battery - 1st Infantry Brigade - 1st Division",
        "2nd Trench Mortar Battery - 2nd Infantry Brigade - 1st Division",
        "3rd Trench Mortar Battery - 3rd Infantry Brigade - 1st Division",
        "4th Trench Mortar Battery - 4th Infantry Brigade - 2nd Division",
        "5th Trench Mortar Battery - 5th Infantry Brigade - 2nd Division",
        "6th Trench Mortar Battery - 6th Infantry Brigade - 2nd Division",
        "7th Trench Mortar Battery - 7th Infantry Brigade - 3rd Division",
        "8th Trench Mortar Battery - 8th Infantry Brigade - 3rd Division",
        "9th Trench Mortar Battery - 9th Infantry Brigade - 3rd Division",
        "10th Trench Mortar Battery - 10th Infantry Brigade - 4th Division",
        "11th Trench Mortar Battery - 11th Infantry Brigade - 4th Division",
        "12th Trench Mortar Battery - 12th Infantry Brigade - 4th Division",
        "2nd Howitzer Battery - 1st Brigade C.F.A. - 1st Division",
        "48th Howitzer Battery - 2nd Brigade C.F.A. - 1st Division",
        "23rd Howitzer Battery - 5th Brigade C.F.A. - 2nd Division",
        "22nd Howitzer Battery - 6th Brigade C.F.A. - 2nd Division",
        "36th Howitzer Battery - 9th Brigade C.F.A. - 3rd Division",
        "35th Howitzer Battery - 10th Brigade C.F.A. - 3rd Division",
        "9th Howitzer Battery - 3rd Brigade C.F.A. - 4th Division",
        "21st Howitzer Battery - 4th Brigade C.F.A. - 4th Division",
        " - 1st Div. Ammunition Column - 1st Division",
        " - 2nd Div. Ammunition Column - 2nd Division",
        " - 3rd Div. Ammunition Column - 3rd Division",
        " - 4th Div. Ammunition Column - 4th Division",
        "1st Battalion - 1st Brigade Cdn. Engineers - 1st Division",
        "2nd Battalion - 1st Brigade Cdn. Engineers - 1st Division",
        "3rd Battalion - 1st Brigade Cdn. Engineers - 1st Division",
        "4th Battalion - 2nd Brigade Cdn. Engineers - 2nd Division",
        "5th Battalion - 2nd Brigade Cdn. Engineers - 2nd Division",
        "6th Battalion - 2nd Brigade Cdn. Engineers - 2nd Division",
        "7th Battalion - 3rd Brigade Cdn. Engineers - 3rd Division",
        "8th Battalion - 3rd Brigade Cdn. Engineers - 3rd Division",
        "9th Battalion - 3rd Brigade Cdn. Engineers - 3rd Division",
        "10th Battalion - 4th Brigade Cdn. Engineers - 4th Division",
        "11th Battalion - 4th Brigade Cdn. Engineers - 4th Division",
        "12th Battalion - 4th Brigade Cdn. Engineers - 4th Division",
        " - 1st Div. Signal Company - 1st Division",
        " - 2nd Div. Signal Company - 2nd Division",
        " - 3rd Div. Signal Company - 3rd Division",
        " - 4th Div. Signal Company - 4th Division",
        " - 1st Bn. Cdn. Machine Gun Corps - 1st Division",
        " - 2nd Bn. Cdn. Machine Gun Corps - 2nd Division",
        " - 3rd Bn. Cdn. Machine Gun Corps - 3rd Division",
        " - 4th Bn. Cdn. Machine Gun Corps - 4th Division",
        " - 1st Divisional Train C.A.S.C. - 1st Division",
        " - 2nd Divisional Train C.A.S.C. - 2nd Division",
        " - 3rd Divisional Train C.A.S.C. - 3rd Division",
        " - 4th Divisional Train C.A.S.C. - 4th Division",
        " - No. 1 Field Ambulance - 1st Division",
        " - No. 2 Field Ambulance - 1st Division",
        " - No. 3 Field Ambulance - 1st Division",
        " - No. 4 Field Ambulance - 2nd Division",
        " - No. 5 Field Ambulance - 2nd Division",
        " - No. 6 Field Ambulance - 2nd Division",
        " - No. 8 Field Ambulance - 3rd Division",
        " - No. 9 Field Ambulance - 3rd Division",
        " - No. 10 Field Ambulance - 3rd Division",
        " - No. 11 Field Ambulance - 4th Division",
        " - No. 12 Field Ambulance - 4th Division",
        " - No. 13 Field Ambulance - 4th Division",
        " - 1st Div. Employment Company - 1st Division",
        " - 2nd Div. Employment Company - 2nd Division",
        " - 3rd Div. Employment Company - 3rd Division",
        " - 4th Div. Employment Company - 4th Division",
        " - Royal Canadian Dragoons - Cavalry",
        " - Lord Strathcona's Horse (Royal Canadians) - Cavalry",
        " - Fort Garry Horse - Cavalry",
        " - Canadian Light Horse - Cavalry",
        " - R.N.W.M.P. Squadron - Cavalry",
        " - R.C.H.A. Brigade C.F.A. - Artillery",
        "24th Field Battery - 8th Army Brigade - Artillery",
        "30th Field Battery - 8th Army Brigade - Artillery",
        "32nd Field Battery - 8th Army Brigade - Artillery",
        "43rd Howitzer Battery - 8th Army Brigade - Artillery",
        "8th Army Bde. Ammunition Column - 8th Army Brigade - Artillery",
        " - E Anti-Aircraft Battery - Artillery",
        " - Corps Heavy Artillery - Artillery",
        "1st Siege Battery - 1st Brigade C.G.A. - Artillery",
        "3rd Siege Battery - 1st Brigade C.G.A. - Artillery",
        "7th Siege Battery - 1st Brigade C.G.A. - Artillery",
        "9th Siege Battery - 1st Brigade C.G.A. - Artillery",
        "1st Heavy Battery - 2nd Brigade C.G.A. - Artillery",
        "2nd Heavy Battery - 2nd Brigade C.G.A. - Artillery",
        "2nd Siege Battery - 2nd Brigade C.G.A. - Artillery",
        "4th Siege Battery - 2nd Brigade C.G.A. - Artillery",
        "5th Siege Battery - 2nd Brigade C.G.A. - Artillery",
        "6th Siege Battery - 2nd Brigade C.G.A. - Artillery",
        "8th Siege Battery - 3rd Brigade C.G.A - Artillery",
        "10th Siege Battery - 3rd Brigade C.G.A - Artillery",
        "11th Siege Battery - 3rd Brigade C.G.A - Artillery",
        "12th Siege Battery - 3rd Brigade C.G.A - Artillery",
        " - 5th Divisional Artillery - Artillery",
        "52nd Field Battery - 13th Brigade C.F.A. - Artillery",
        "53rd Field Battery - 13th Brigade C.F.A. - Artillery",
        "55th Field Battery - 13th Brigade C.F.A. - Artillery",
        "51st Howitzer Battery - 13th Brigade C.F.A. - Artillery",
        "60th Field Battery - 14th Brigade C.F.A. - Artillery",
        "61st Field Battery - 14th Brigade C.F.A. - Artillery",
        "66th Field Battery - 14th Brigade C.F.A. - Artillery",
        "58th Howitzer Battery - 14th Brigade C.F.A. - Artillery",
        " - 5th Div. Ammunition Column - Artillery",
        " - 1st Army Troops Companies - Engineers",
        " - 2nd Army Troops Companies - Engineers",
        " - 3rd Army Troops Companies - Engineers",
        " - 4th Army Troops Companies - Engineers",
        " - 5th Army Troops Companies - Engineers",
        " - Anti-Aircraft Searchlight Company - Engineers",
        " - 3rd Tunnelling Company - Engineers",
        " - Corps Survey Section - Engineers",
        " - 1st Tramways Company - Engineers",
        " - 2nd Tramways Company - Engineers",
        " - 1st Motor M.G. Brigade - Machine Gun Corps",
        " - 2nd Motor M.G. Brigade - Machine Gun Corps",
        " - Corps Troops M.T. Company - Army Service Corps",
        " - 1st Division M.T. Company - Army Service Corps",
        " - 2nd Division M.T. Company - Army Service Corps",
        " - 3rd Division M.T. Company - Army Service Corps",
        " - 4th Division M.T. Company - Army Service Corps",
        " - Engineers M.T. Company - Army Service Corps",
        " - Motor Machine Gun M.T. Company - Army Service Corps",
        " - 5th Div. Artillery M.T. Detachment - Army Service Corps",
        " - 5th Divisional Train Detachment - Army Service Corps",
        " - Number 1 General Hospital - Medical Corps",
        " - Number 2 General Hospital - Medical Corps",
        " - Number 3 General Hospital - Medical Corps",
        " - Number 6 General Hospital - Medical Corps",
        " - Number 7 General Hospital - Medical Corps",
        " - Number 8 General Hospital - Medical Corps",
        " - Number 2 Stationary Hospital - Medical Corps",
        " - Number 3 Stationary Hospital - Medical Corps",
        " - Number 7 Stationary Hospital - Medical Corps",
        " - Number 8 Stationary Hospital - Medical Corps",
        " - Number 9 Stationary Hospital - Medical Corps",
        " - Number 10 Stationary Hospital - Medical Corps",
        " - Forestry Corps Hospital - Medical Corps",
        " - Number 1 Casualty Clearing Station - Medical Corps",
        " - Number 2 Casualty Clearing Station - Medical Corps",
        " - Number 3 Casualty Clearing Station - Medical Corps",
        " - Number 4 Casualty Clearing Station - Medical Corps",
        " - Number 7 (Cavalry) Field Ambulance - Medical Corps",
        " - Number 14 Field Ambulance - Medical Corps",
        " - Canadian Overseas Railway Construction Corps - Railway Troops",
        " - 1st Battalion - Railway Troops",
        " - 2nd Battalion - Railway Troops",
        " - 3rd Battalion - Railway Troops",
        " - 4th Battalion - Railway Troops",
        " - 5th Battalion - Railway Troops",
        " - 6th Battalion - Railway Troops",
        " - 7th Battalion - Railway Troops",
        " - 8th Battalion - Railway Troops",
        " - 9th Battalion - Railway Troops",
        " - 10th Battalion - Railway Troops",
        " - 11th Battalion - Railway Troops",
        " - 12th Battalion - Railway Troops",
        " - 13th Battalion - Railway Troops",
        " - 1st Infantry Works Coy. - Labour",
        " - 2nd Infantry Works Coy. - Labour",
        " - 3rd Infantry Works Coy. - Labour",
        " - 4th Infantry Works Coy. - Labour",
        " - 5th Area Employment  Coy. - Labour",
        " - 6th Area Employment  Coy. - Labour",
        " - 7th Area Employment  Coy. - Labour",
        " - 8th Area Employment  Coy. - Labour",
        " - 9th Area Employment  Coy. - Labour",
        " - Canadian Cyclist Battalion - Miscellaneous",
        " - Corps Signal Company - Miscellaneous",
        " - Corps Reinforcement Camp - Miscellaneous",
        " - Corps Schools - Miscellaneous",
        " - Forestry Company  - Miscellaneous"
    ]
}
