//
//  HandPoseResult.swift
//  LearnLibras
//
//  Created by Gustavo Batista on 16/09/24.
//

import Foundation

struct HandPoseResult {

    let character: String
    let confidence: Double
    let output: ASLModelOutput

    init?(output prediction: ASLModelOutput) {
        guard let confidence = prediction.labelProbabilities[prediction.label],
              confidence >= 0.9
        else { return nil }

        character = prediction.label.first!.uppercased()
        self.confidence = confidence
        output = prediction
    }
}
