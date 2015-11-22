//
//  CorrutionChooseTVCTableViewController.swift
//  record
//
//  Created by Lee Janghyup on 11/22/15.
//  Copyright © 2015 Lee Janghyup. All rights reserved.
//

import UIKit

class CorrutionChooseTVCTableViewController: UITableViewController {
    
    @IBOutlet weak var corruptionTextView: UITextView!
    var typeOfCorruption : String!

    override func viewDidLoad() {
        super.viewDidLoad()

         }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if  indexPath.section == 0 && indexPath.row == 0 {
         
            typeOfCorruption = "Bribe"
            performSegueWithIdentifier("curruptionToInfo", sender: self)
            
        }
        
        if indexPath.section == 0 && indexPath.row == 1 {
        
            typeOfCorruption = "Extortion"
            performSegueWithIdentifier("curruptionToInfo", sender: self)
            
    }
    }
    
    
    @IBAction func saveButtonTapped(sender: AnyObject) {
        typeOfCorruption = corruptionTextView.text
        performSegueWithIdentifier("curruptionToInfo", sender: self)
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "curruptionToInfo") {
            
            
            let destViewController : InfoPage = segue.destinationViewController as! InfoPage
            destViewController.typeOfCorruption = typeOfCorruption
            
            
            
        }

        
    }
    
       
}
