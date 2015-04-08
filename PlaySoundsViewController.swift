//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Matthew Brown on 3/18/15.
//  Copyright (c) 2015 Crest Technologies. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController
{
    var audioPlayer: AVAudioPlayer!
    var receivedAudio: RecordedAudio!
    var audioEngine: AVAudioEngine!
    var audioFile: AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathURL, error: nil)
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathURL, error: nil)
    }
    
    @IBAction func slowAudioSpeed() {
        playAudioWithVariablePitchAndOrRate(1.0, rate: 0.5)
    }

    @IBAction func fastAudioSpeed() {
        playAudioWithVariablePitchAndOrRate(1.0, rate: 1.5)
    }
    
    @IBAction func playChipmunkAudio() {
        playAudioWithVariablePitchAndOrRate(1000, rate: 1.0)
    }
    
    @IBAction func playDarthVaderAudio() {
        playAudioWithVariablePitchAndOrRate(-1000, rate: 1.0)
    }
    
    func playAudioWithVariablePitchAndOrRate(pitch: Float, rate: Float) {
        resetAudioEngine()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        var changeRateEffect = AVAudioUnitTimePitch()
        changeRateEffect.rate = rate
        audioEngine.attachNode(changeRateEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: changeRateEffect, format: nil)
        audioEngine.connect(changeRateEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        audioPlayerNode.play()
    }
    
    func resetAudioEngine() {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.currentTime = 0.0
    }
    
    @IBAction func stopAudioPlayback() {
        resetAudioEngine()
    }

}
