//
//  HandDetectorView.swift
//  LearnLibras
//
//  Created by Gustavo Batista on 17/09/24.
//

import SwiftUI

struct HandDetectorView: View {

    @EnvironmentObject private var handPoseDetector: HandPoseDetector
    @StateObject var viewModel: ViewModel

    init(wordValue: WordValue = .init()) {
        let viewModel: ViewModel = .init(
            wordValue: wordValue,
            valueBinding: nil
        )
        
        _viewModel = .init(wrappedValue: viewModel)
    }

    init(wordValue: Binding<WordValue>) {
        let viewModel: ViewModel = .init(
            wordValue: wordValue.wrappedValue,
            valueBinding: wordValue
        )

        _viewModel = .init(wrappedValue: viewModel)
    }

    var body: some View {
        CameraView()
            .overlay(overlayView, alignment: .top)
            .cornerRadius(10)
            .onAppear {
                viewModel.onAppear(handPoseDetector: handPoseDetector)
            }
    }
}
