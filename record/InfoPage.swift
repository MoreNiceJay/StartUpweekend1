//
//  InfoPage.swift
//  record
//
//  Created by Lee Janghyup on 11/21/15.
//  Copyright © 2015 Lee Janghyup. All rights reserved.
//

import UIKit
import AVFoundation
import MapKit

class InfoPage: UIViewController, CLLocationManagerDelegate{

    @IBOutlet weak var typeofCorruptionLabel: UILabel!
       @IBOutlet weak var locationInfo: UILabel!
    var coreLocationManger = CLLocationManager()
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var organizationTextField: UITextField!
    
    var audioRecorder:AVAudioRecorder!
    var audioPlayer:AVAudioPlayer!
    var typeOfCorruption : String!
    var locationManager :LocationManager!

    let recordSettings = [AVSampleRateKey : NSNumber(float: Float(44100.0)),
        AVFormatIDKey : NSNumber(int: Int32(kAudioFormatMPEG4AAC)),
        AVNumberOfChannelsKey : NSNumber(int: 1),
        AVEncoderAudioQualityKey : NSNumber(int: Int32(AVAudioQuality.Medium.rawValue))]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        coreLocationManger.delegate = self
        locationManager = LocationManager.sharedInstance
        
        let authorizationCode = CLLocationManager.authorizationStatus()
        
        if authorizationCode == CLAuthorizationStatus.NotDetermined && coreLocationManger.respondsToSelector("requestAlwaysAuthorization") || respondsToSelector("requestWhenInUseAuthorization"){
            if NSBundle.mainBundle().objectForInfoDictionaryKey("NSLocationAlwaysUsageDescription") != nil { coreLocationManger.requestAlwaysAuthorization() }else {
                print("No description provided")
            
            
        }
        }else {
            getLocation()
        }
        
    
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        typeofCorruptionLabel.text = typeOfCorruption
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playButtonTapped(sender: AnyObject) {
    
    do {
    try audioPlayer = AVAudioPlayer(contentsOfURL: audioRecorder.url)
    audioPlayer.play()
    } catch {
    }

}
    func getLocation() {
        locationManager.startUpdatingLocationWithCompletionHandler{(latitude, longitude, status, verboseMessage, error) -> () in
            self.displayLocation(CLLocation(latitude: latitude, longitude: longitude))
            }
        
    }
    
    func displayLocation(location : CLLocation){
        
    
        locationManager.reverseGeocodeLocationWithCoordinates(location) { (reverseGecodeInfo, placemark, error) -> Void in
let address = reverseGecodeInfo?.objectForKey("formattedAddress") as! String
        self.locationInfo.text = address
        }
    }
    
    @IBAction func userInfoUnwindToSegue (segue : UIStoryboardSegue) {
        
        
    }
    
    @IBAction func saveButtonTapped(sender: AnyObject) {
        
        var nameText = nameTextField.text
        var organizationText = organizationTextField.text
        if (typeofCorruptionLabel == "selected yet" || nameText!.isEmpty ||
            organizationText!.isEmpty)  {
                self.alert("unfiled", message : "All information must be filled")
        
        
        }else{
            let emailAlert : UIAlertController = UIAlertController(title: "Submit ", message: "Providing additional information will increase the chances of an action being taken by a corresponding authority. Do you want to provide more detail? ", preferredStyle: UIAlertControllerStyle.Alert)
            
            
            let okAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default, handler: { Void in
                
                
                


            })
            
            let nkAction = UIAlertAction(title: "No. Submit now.", style: UIAlertActionStyle.Default, handler: { Void in
                
                
                let myAlert = UIAlertController(title: "Saved", message: "Your tracking# 000022", preferredStyle: UIAlertControllerStyle.Alert)
                
                
                
                
                let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default) {
                    action in
                    
                    self.performSegueWithIdentifier("done", sender: self)
                }
                myAlert.addAction(okAction)
                self.presentViewController(myAlert, animated: true, completion: nil)
                

            })
            emailAlert.addAction(okAction)
            emailAlert.addAction(nkAction)
            
            
            self.presentViewController(emailAlert, animated: true, completion: nil)

            
            
            
           
    }
            
            
        
        
    }
    
func alert(title : String, message : String) {
    
    let myAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
    let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
    myAlert.addAction(okAction)
    self.presentViewController(myAlert, animated: true, completion: nil)


    }
    
}
