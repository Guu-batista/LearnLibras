//
//  CameraManager.swift
//  LearnLibras
//
//  Created by Gustavo Batista on 16/09/24.
//

import AVFoundation
import SwiftUI

@MainActor class CameraManager: ObservableObject {

    @Published private(set) var setupStatus: SetupStatus = .notStarted
    @Published private(set) var runStatus: RunStatus = .stopped
    @Published private(set) var currentCamera: AVCaptureDevice.Position? = nil

    let captureSession: AVCaptureSession = .init()
    let captureOutput: AVCaptureVideoDataOutput = .init()

    private var frontCamera: AVCaptureDeviceInput? = nil
    private var backCamera: AVCaptureDeviceInput? = nil
}
extension CameraManager {

    func setupCamera() async {
        guard setupStatus == .notStarted else { return }

        setupStatus = .loading

        let cameraStatus: Bool = await Task.detached {
            await AVCaptureDevice.requestAccess(for: .video)
        }.value

        guard cameraStatus else {
            setupStatus = .accessDenied
            return
        }

        guard await setupCapture() else {
            setupStatus = .failed
            return
        }

        setupStatus = .success
    }

    func startCapture() async {
        guard setupStatus == .success, runStatus == .stopped else { return }

        runStatus = .loading

        await Task.detached {
            await self.captureSession.startRunning()
        }.value

        runStatus = .running
    }

    func stopCapture() async {
        guard setupStatus == .success, runStatus == .running else { return }

        runStatus = .loading

        await Task.detached {
            await self.captureSession.stopRunning()
        }.value

        runStatus = .stopped
    }

    func switchCamera() {
        guard let frontCamera, let backCamera else { return }

        switch currentCamera {
        case .front:
            captureSession.removeInput(frontCamera)
            captureSession.addInput(backCamera)
            currentCamera = .back

        case .back:
            captureSession.removeInput(backCamera)
            captureSession.addInput(frontCamera)
            currentCamera = .front

        default:
            break
        }
    }

    enum SetupStatus: CaseIterable {
        case notStarted, accessDenied, loading, failed, success
    }

    enum RunStatus: CaseIterable {
        case stopped, loading, running
    }
}

private extension CameraManager {
    
    func setupCapture() async -> Bool {
        captureSession.sessionPreset = .vga640x480
        captureSession.beginConfiguration()

        guard
            await setupInputs(),
            captureSession.canAddOutput(captureOutput)
        else { return false }

        captureOutput.connection(with: .video)?.isEnabled = true
        captureOutput.alwaysDiscardsLateVideoFrames = true

        captureOutput.connection(with: .video)?.isVideoMirrored = false

        captureSession.addOutput(captureOutput)

        captureSession.commitConfiguration()
        return true
    }

    func setupInputs() async -> Bool {
        async let macCameraInput: AVCaptureDeviceInput? = await Task.detached {
            guard let camera: AVCaptureDevice = .default(
                .builtInWideAngleCamera,
                for: .video,
                position: .unspecified
            ) else { return nil }

            return try? .init(device: camera)
        }.value

        if let macCameraInput = await macCameraInput {
            currentCamera = .front
            captureSession.addInput(macCameraInput)
            return true
        }

        return false
    }
}

