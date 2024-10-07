//
//  HandDetector+UI.swift
//  LearnLibras
//
//  Created by Gustavo Batista on 17/09/24.
//

import SwiftUI

extension HandDetectorView {

    var overlayView: some View {
        HStack {
            Spacer()
            ZStack {
                charactersView
                    .opacity(viewModel.isCompleted ? 0 : 1)
            }

            Spacer()
        }
        .padding()
        .background(.ultraThinMaterial)
        .animation(.easeInOut, value: viewModel.isCompleted)
        .animation(.easeInOut, value: viewModel.wordValue.currentWord ?? "")
        .animation(.easeInOut, value: viewModel.wordValue.collectedLetters)
    }

    @ViewBuilder var charactersView: some View {
        if let letters = viewModel.letters {
            wordView(letters: letters)
        }

        if let letters = viewModel.wordValue.collectedLetters {
            collectedView(letters: letters.joined(separator: " "))
        }
    }

    func wordView(letters: ViewModel.CollectedLetters) -> some View {
        HStack {
            ForEach(Array(letters.enumerated()), id: \.offset) { (_, character) in
                Text(verbatim: character.letter)
                    .font(.system(size: 75).weight(.medium))
                    .opacity(character.isCompleted ? 1 : 0.5)
            }
        }
    }

    func collectedView(letters: String) -> some View {
        HStack {
            Spacer()
            Text(verbatim: letters)
                .font(.system(size: 75).weight(.medium))
                .frame(maxWidth: .infinity)

        }
    }
}
