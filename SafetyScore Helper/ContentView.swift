//
//  ContentView.swift
//  SafetyScore Helper
//
//  Created by Orion on 10/6/21.
//

import SwiftUI
import CoreMotion

let mediaManager = MediaManager()
let coreMotionAdapter = CoreMotionAdapter(mediaManager: mediaManager)

struct ContentView: View {
    
    @State var acceleration: CMAcceleration = CMAcceleration()
    
    var body: some View {
        LazyVStack {
            Text("X Acceleration: \(acceleration.x, specifier: "%.2f")")
                .padding()
            Text("Y Acceleration: \(acceleration.y, specifier: "%.2f")")
                .padding()
            Text("Z Acceleration: \(acceleration.z, specifier: "%.2f")")
                .padding()
            Button(action: {
                mediaManager.overridePlayNormalSound()
            }, label: {Text("Play normal sound")})
                .padding()
            Button(action: {
                mediaManager.overrideStopNormalSound()
            }, label: {Text("Stop normal sound")})
                .padding()
            Button(action: {
                mediaManager.playWarningSound()
            }, label: {Text("Play warning sound")})
                .padding()
            Button(action: {
                mediaManager.stopWarningSound()
            }, label: {Text("Stop warning sound")})
                .padding()
            Button(action: {
                mediaManager.playErrorSound()
            }, label: {Text("Play error sound")})
                .padding()
            Button(action: {
                mediaManager.stopErrorSound()
            }, label: {Text("Stop error sound")})
                .padding()
        }.onAppear(perform: {
            coreMotionAdapter.startQueuedUpdates()
        }).onReceive(coreMotionAdapter.accelerationPublisher, perform: { (updatedAccelerataion: CMAcceleration) in
            self.acceleration = updatedAccelerataion
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
