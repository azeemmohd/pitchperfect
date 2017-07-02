//
//  RecordSoundsViewController
//  PitchPerfect
//
//  Created by Azeem Mohammad on 01/07/17.
//  Copyright © 2017 Azeem Mohammad. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    var avAudioRecorder : AVAudioRecorder!
    
    @IBOutlet weak var recordingLabel: UILabel!
    
    @IBOutlet weak var recordingButton: UIButton!
    
    
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    enum RecordingState { case recording, notRecording }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    func configureUI(_ recordState: RecordingState) {
        switch(recordState) {
        case .recording:
            stopRecordingButton.isEnabled = true
            recordingButton.isEnabled = false
            recordingLabel.text = "Recording in progress"
        case .notRecording:
            stopRecordingButton.isEnabled = false
            recordingButton.isEnabled = true
            recordingLabel.text = "Tap to Record"
  
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureUI(.notRecording)
    }
    
    
    
    @IBAction func beginRecording(_ sender: Any) {
        recordAudio(self)
    }
    
    
    @IBAction func stopRecording(_ sender: Any) {
        avAudioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
        
    }
    
    
    @IBAction func recordAudio(_ sender: AnyObject) {
        
        configureUI(.recording)
        
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

