//
//  HandDetectorView+ViewModel.swift
//  LearnLibras
//
//  Created by Gustavo Batista on 17/09/24.
//

import SwiftUI

extension HandDetectorView {
    @MainActor class ViewModel: ObservableObject {

        @Published var wordValue: WordValue
        @Published private(set) var isCompleted: Bool = false
        @Published private(set) var letters: CollectedLetters?

        private var valueBinding: Binding<WordValue>?

        typealias CollectedLetters = [(letter: String, isCompleted: Bool)]

        init(wordValue: WordValue,
             valueBinding: Binding<WordValue>?) {
            self.wordValue = wordValue
            self.valueBinding = valueBinding
            self.letters = wordValue.currentWordLetters
        }
    }
}

extension HandDetectorView.ViewModel {

    func onAppear(handPoseDetector: HandPoseDetector) {
        valueBindingTask()
        lettersTask()
        getHandPosesTask(handPoseDetector: handPoseDetector)
    }
}

private extension HandDetectorView.ViewModel {

    func getHandPosesTask(handPoseDetector: HandPoseDetector) {
        let filteredPoses = handPoseDetector.$currentPose
            .compactMap({ $0 })
            .collect(5)
            .filter({ poses in poses.allSatisfy({ $0.character == poses.first?.character }) })

        let poseCharacters = filteredPoses
            .compactMap({ $0.first })
            .removeDuplicates(by: { $0.character == $1.character })
            .debounce(for: 0.5, scheduler: DispatchQueue.main)

        Task { [weak self] in
            for await pose in poseCharacters.values {
                guard let self else { return }
                self.wordValue.onLetterReceived(letter: pose.character)
            }
        }
    }

    func valueBindingTask() {
        Task {
            for await value in $wordValue.values {
                self.valueBinding?.wrappedValue = value
            }
        }
    }

    func lettersTask() {
        let wordValues = $wordValue
            .scan((wordValue, false)) {
                ($1, $0.0.completedWords != $1.completedWords)
            }
            .values

        Task {
            for await (wordValue, isWordCompleted) in wordValues {
                switch isWordCompleted {
                case false:
                    self.letters = wordValue.currentWordLetters

                case true:
                    self.letters = .init()
                    self.isCompleted = true

                    guard !wordValue.isCompleted else { break }

                    try? await Task.sleep(for: .seconds(1))
                    self.isCompleted = false
                    self.letters = wordValue.currentWordLetters
                }
            }
        }
    }
}
