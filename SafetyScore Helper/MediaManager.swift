//
//  MediaManager.swift
//  SafetyScore Helper
//
//  Created by Orion on 10/6/21.
//

import Foundation
import AVKit

class MediaManager {
    
    private let normalSound = NSDataAsset(name: "normalSound")
    private let warningSound = NSDataAsset(name: "warningSound")
    private let errorSound = NSDataAsset(name: "errorSound")
    
    private let normalSoundPlayer: AVAudioPlayer
    private let warningSoundPlayer: AVAudioPlayer
    private let errorSoundPlayer: AVAudioPlayer
    
    private var overrideNormalSound = false
    
    init() {
        normalSoundPlayer = try! AVAudioPlayer(data: normalSound!.data, fileTypeHint: "mp3")
        warningSoundPlayer = try! AVAudioPlayer(data: warningSound!.data, fileTypeHint: "mp3")
        errorSoundPlayer = try! AVAudioPlayer(data: errorSound!.data, fileTypeHint: "mp3")
    }
    
    func playNormalSound() {
        if (normalSoundPlayer.isPlaying) {
            return
        }
        
        if (warningSoundPlayer.isPlaying) {
            stopWarningSound()
        }
        if (errorSoundPlayer.isPlaying) {
            stopErrorSound()
        }

        normalSoundPlayer.currentTime = 0
        normalSoundPlayer.play()
    }
    
    func stopNormalSound() {
        if (normalSoundPlayer.isPlaying && !overrideNormalSound) {
            normalSoundPlayer.stop()
        }
    }
    
    func overridePlayNormalSound() {
        overrideNormalSound = true
        normalSoundPlayer.currentTime = 0
        normalSoundPlayer.play()
    }

    func overrideStopNormalSound() {
        overrideNormalSound = false
        normalSoundPlayer.stop()
    }
    
    func playWarningSound() {
        if (warningSoundPlayer.isPlaying) {
            return
        }
        
        if (normalSoundPlayer.isPlaying) {
            stopNormalSound()
        }
        if (errorSoundPlayer.isPlaying) {
            stopErrorSound()
        }

        warningSoundPlayer.currentTime = 0
        warningSoundPlayer.play()
    }
    
    func stopWarningSound() {
        if (warningSoundPlayer.isPlaying) {
            warningSoundPlayer.stop()
        }
    }
    
    func playErrorSound() {
        if (errorSoundPlayer.isPlaying) {
            return
        }

        if (normalSoundPlayer.isPlaying) {
            stopNormalSound()
        }
        if (warningSoundPlayer.isPlaying) {
            stopWarningSound()
        }
        
        errorSoundPlayer.currentTime = 0
        errorSoundPlayer.play()
    }
    
    func stopErrorSound() {
        if (errorSoundPlayer.isPlaying) {
            errorSoundPlayer.stop()
        }
    }
}
