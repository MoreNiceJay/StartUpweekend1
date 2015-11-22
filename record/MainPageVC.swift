//
//  ViewController.swift
//  record
//
//  Created by Lee Janghyup on 11/21/15.
//  Copyright © 2015 Lee Janghyup. All rights reserved.
//

import UIKit



class MainPageVC: UIViewController {

   
    @IBOutlet weak var switchOn: UISwitch!
    @IBOutlet weak var voiceVideoLabel: UILabel!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func switchOn(sender: AnyObject) {
        
        if switchOn.on {
            
            
            voiceVideoLabel.text = "Voice only"

            
            
            
        }else {
            voiceVideoLabel.text = "Video"

        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   
}
