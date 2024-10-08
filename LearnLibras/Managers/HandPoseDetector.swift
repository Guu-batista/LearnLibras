//
//  HandPoseDetector.swift
//  LearnLibras
//
//  Created by Gustavo Batista on 16/09/24.
//

import SwiftUI
import Vision


@MainActor class HandPoseDetector: ObservableObject {


    @Published private(set) var setupStatus: SetupStatus = .notStarted
    @Published private(set) var currentPose: HandPoseResult? = nil

    private(set) var model: ASLModel? = nil
}

extension HandPoseDetector {


    func setup() async {
        await setupModels()
    }

    nonisolated func onImageReceived(buffer imageBuffer: CVImageBuffer) {
        Task {
            await MainActor.run {
                if let pose = try? getHandPoseResult(buffer: imageBuffer) {
                    currentPose = pose
                }
            }
        }
    }

    enum SetupStatus: CaseIterable {
        case notStarted, loading, success, failed
    }
}


private extension HandPoseDetector {

    func setupModels() async {
        guard setupStatus == .notStarted else { return }

        guard let modelURL = Bundle.main.url(forResource: "ASLModel", withExtension: "mlmodelc") else {
            print("ML Model (ASLModel.mlmodelc) not found.")
            setupStatus = .failed
            return
        }

        setupStatus = .loading

        do {
            let model: ASLModel = try await Task.detached {
                try .init(contentsOf: modelURL)
            }.value

            self.model = model
        } catch {
            print(error.localizedDescription)
            setupStatus = .failed
            return
        }

        setupStatus = .success
    }

    func getHandPoseResult(buffer imageBuffer: CVImageBuffer) throws -> HandPoseResult? {
        guard setupStatus == .success else { return nil }

        let request: VNDetectHumanHandPoseRequest = .init()
        request.maximumHandCount = 1
        request.revision = VNDetectHumanHandPoseRequestRevision1

        let handler: VNImageRequestHandler = .init(cvPixelBuffer: imageBuffer)
        try handler.perform([request])

        if let poses = try request.results?.first?.keypointsMultiArray(),
           let prediction = try model?.prediction(poses: poses),
           let result = HandPoseResult(output: prediction) {
            return result
        }

        return nil
    }
}
