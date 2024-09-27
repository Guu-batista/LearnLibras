//
//  CameraView.swift
//  LearnLibras
//
//  Created by Gustavo Batista on 17/09/24.
//

import SwiftUI


struct CameraView: View {

    @EnvironmentObject var handPoseDetector: HandPoseDetector
    @EnvironmentObject var cameraManager: CameraManager
    
    var body: some View {
        AVCaptureView()
            .background(.ultraThinMaterial)
            .task(onAppear)
    }
}
