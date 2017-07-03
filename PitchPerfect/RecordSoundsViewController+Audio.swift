//
//  RecordSoundsViewController+Audio.swift
//  PitchPerfect
//
//  Created by Azeem Mohammad on 03/07/17.
//  Copyright © 2017 Azeem Mohammad. All rights reserved.
//

import UIKit
import AVFoundation

// MARK: - RecordSoundsViewController: AVAudioRecorderDelegate

extension RecordSoundsViewController: AVAudioRecorderDelegate {
    
    @IBAction func recordAudio(_ sender: AnyObject) {
        
        configureUI(true)
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        try! avAudioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        avAudioRecorder.delegate = self
        avAudioRecorder.isMeteringEnabled = true
        avAudioRecorder.prepareToRecord()
        avAudioRecorder.record()
    }
    
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: "stopRecording", sender: avAudioRecorder.url)
        }
        else {
            print("Recording Failed");
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordingURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordingURL
        }
    }
    
}
