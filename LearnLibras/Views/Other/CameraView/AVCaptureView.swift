//
//  CameraView+AVCaptureView.swift
//  LearnLibras
//
//  Created by Gustavo Batista on 17/09/24.
//
import AVFoundation
import SwiftUI
import AppKit

extension CameraView {
    struct AVCaptureView: NSViewRepresentable {

        @EnvironmentObject private var cameraManager: CameraManager
        @EnvironmentObject private var handPoseDetector: HandPoseDetector

        func makeNSView(context: Context) -> NSView {
            context.coordinator.makeNSView(with: cameraManager.captureSession)
        }

        func updateNSView(_ nsView: NSView, context: Context) {
            context.coordinator.updateFrame(with: nsView.frame.size)
        }

        func makeCoordinator() -> Coordinator {
            let coordinator: Coordinator = .init(handPoseDetector: handPoseDetector)
            cameraManager.captureOutput.setSampleBufferDelegate(coordinator, queue: coordinator.queue)
            return coordinator
        }

        static func dismantleNSView(_ nsView: NSView, coordinator: Coordinator) {
            coordinator.stopOrientationTask()
        }
    }
}

extension CameraView.AVCaptureView {
    @MainActor class Coordinator: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate {

        let handPoseDetector: HandPoseDetector
        let queue: DispatchQueue = .init(
            label: "AVCaptureViewCoordinator",
            autoreleaseFrequency: .workItem
        )

        private var nsView: NSView? = nil
        private var capturePreview: AVCaptureVideoPreviewLayer? = nil
        private var orientationTask: Task<Void, Never>? = nil

        init(handPoseDetector: HandPoseDetector) {
            self.handPoseDetector = handPoseDetector
        }

        nonisolated func captureOutput(
            _ output: AVCaptureOutput,
            didOutput sampleBuffer: CMSampleBuffer,
            from connection: AVCaptureConnection
        ) {
            guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }

            handPoseDetector.onImageReceived(buffer: imageBuffer)

            guard let flippedBuffer = CIImage(cvImageBuffer: imageBuffer)
                .oriented(.upMirrored)
                .pixelBuffer else { return }

            handPoseDetector.onImageReceived(buffer: flippedBuffer)
        }

        func makeNSView(with session: AVCaptureSession) -> NSView {
            let nsView: NSView = .init()
            let capturePreview: AVCaptureVideoPreviewLayer = .init(session: session)

            capturePreview.videoGravity = .resizeAspectFill
            nsView.layer = CALayer()
            nsView.layer?.addSublayer(capturePreview)

            
            capturePreview.setAffineTransform(CGAffineTransform(scaleX: -1, y: 1))
            

            self.nsView = nsView
            self.capturePreview = capturePreview

            return nsView
        }


        func updateFrame(with size: CGSize) {
            capturePreview?.frame.size = size
        }
        
        func stopOrientationTask() {
            orientationTask?.cancel()
        }
    }
}
