//
//  RecordSoundsViewController
//  PitchPerfect
//
//  Created by Azeem Mohammad on 01/07/17.
//  Copyright © 2017 Azeem Mohammad. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController{
    
    var avAudioRecorder : AVAudioRecorder!
    
    @IBOutlet weak var recordingLabel: UILabel!
    
    @IBOutlet weak var recordingButton: UIButton!
    
    
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    func configureUI(_ isRecording : Bool) {
        recordingLabel.text = isRecording ? "Recording in progress" : "Tap to Record"
        stopRecordingButton.isEnabled = isRecording
        recordingButton.isEnabled = !isRecording
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureUI(false)
    }
    
    
    
    @IBAction func beginRecording(_ sender: Any) {
        recordAudio(self)
    }
    
    
    @IBAction func stopRecording(_ sender: Any) {
        avAudioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
        
    }
}

