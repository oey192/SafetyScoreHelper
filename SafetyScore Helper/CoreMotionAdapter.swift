//
//  CoreMotionAdapter.swift
//  SafetyScore Helper
//
//  Created by Orion on 10/6/21.
//

import Foundation
import CoreMotion
import Combine

class CoreMotionAdapter {
    
    private let mediaManager: MediaManager
    
    let motion = CMMotionManager()
    let queue = OperationQueue()
    let accelerationPublisher = PassthroughSubject<CMAcceleration, Never>()
    
    init(mediaManager: MediaManager) {
        self.mediaManager = mediaManager
    }
    
    func startQueuedUpdates() {
        if motion.isDeviceMotionAvailable {
            self.motion.deviceMotionUpdateInterval = 1.0 / 60.0
            self.motion.showsDeviceMovementDisplay = true
            self.motion.startDeviceMotionUpdates(using: .xMagneticNorthZVertical,
                                                 to: self.queue, withHandler: { [self] (data, error) in
                // Make sure the data is valid before accessing it.
                if let validData = data {
                    DispatchQueue.main.async {
                        let acceleration = validData.userAcceleration
                        accelerationPublisher.send(acceleration)
                        
                        
                        if (abs(acceleration.x) > 0.4) {
                            mediaManager.playErrorSound()
                        } else if (abs(acceleration.x) > 0.3) {
                            mediaManager.stopWarningSound()
                        } else if (abs(acceleration.x) > 0.2) {
                            mediaManager.playNormalSound()
                        } else {
                            mediaManager.stopNormalSound()
                            mediaManager.stopWarningSound()
                            mediaManager.stopErrorSound()
                        }
                    }
                }
            })
        }
    }
    
}
