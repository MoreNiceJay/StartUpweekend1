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

    
    var locationManager :LocationManager!
    @IBOutlet weak var locationInfo: UILabel!
    var coreLocationManger = CLLocationManager()
    
    
    
    var audioRecorder:AVAudioRecorder!
    var audioPlayer:AVAudioPlayer!
    
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
        
        
        
    
}
