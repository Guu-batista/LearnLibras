//
//  CameraView.swift
//  LearnLibras
//
//  Created by Gustavo Batista on 17/09/24.
//

import SwiftUI


struct CameraView: View {

    // MARK: Properties

    @EnvironmentObject var handPoseDetector: HandPoseDetector
    @EnvironmentObject var cameraManager: CameraManager

    // MARK: View
    
    var body: some View {
        AVCaptureView()
            .background(.ultraThinMaterial)
            .task(onAppear)
    }
}

// MARK: - Previews

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
            .setupPreview()
    }
}
