//
//  RecordingViewController.swift
//  record
//
//  Created by Lee Janghyup on 11/21/15.
//  Copyright © 2015 Lee Janghyup. All rights reserved.
//

import UIKit
import AVFoundation



class RecordingViewController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {

   
    
    var audioRecorder:AVAudioRecorder!
    var audioPlayer:AVAudioPlayer!
    
    let recordSettings = [AVSampleRateKey : NSNumber(float: Float(44100.0)),
        AVFormatIDKey : NSNumber(int: Int32(kAudioFormatMPEG4AAC)),
        AVNumberOfChannelsKey : NSNumber(int: 1),
        AVEncoderAudioQualityKey : NSNumber(int: Int32(AVAudioQuality.Medium.rawValue))]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try audioRecorder = AVAudioRecorder(URL: self.directoryURL()!,
                settings: recordSettings)
            audioRecorder.prepareToRecord()
        } catch {
        }
        
        if (!audioRecorder.recording){
            do {
                try audioPlayer = AVAudioPlayer(contentsOfURL: audioRecorder.url)
                audioPlayer.play()
            } catch {
            }
        
    }

        
    }

    func directoryURL() -> NSURL? {
        let fileManager = NSFileManager.defaultManager()
        let urls = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        let documentDirectory = urls[0] as NSURL
        let soundURL = documentDirectory.URLByAppendingPathComponent("sound.m4a")
        return soundURL
    }
    
    
    @IBAction func doStopAction(sender: AnyObject) {
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession.setActive(false)
        } catch {
        }
        
        performSegueWithIdentifier("recordedToInfo", sender: self)
    }
    
    @IBAction func doPauseAction(sender: AnyObject) {
    }
}


    
