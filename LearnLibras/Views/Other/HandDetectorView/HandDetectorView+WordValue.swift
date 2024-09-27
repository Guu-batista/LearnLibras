//
//  HandDetectorView+WordValue.swift
//  LearnLibras
//
//  Created by Gustavo Batista on 17/09/24.
//

import Foundation

extension HandDetectorView {
    struct WordValue {

        let targetWords: [String]?
        var completedWords: [String] = .init()
        var collectedLetters: [String]?

        var currentWord: String? = nil {
            didSet {
                currentWordLetters = currentWord?.map({ (String($0), false) })
            }
        }

        var currentWordLetters: [(String, Bool)]? {
            didSet {
                if currentWordLetters?.allSatisfy({ $0.1 }) == true {
                    nextWord()
                }
            }
        }

        init(targetWords: [String]? = nil) {
            self.targetWords = targetWords

            switch targetWords {
            case .none:
                currentWordLetters = nil
                collectedLetters = .init()

            case .some:
                collectedLetters = nil
                nextWord()
            }
        }
    }
}

extension HandDetectorView.WordValue {

    var isCompleted: Bool {
        completedWords == targetWords
    }

    var currentLetter: String? {
        currentWordLetters?.first(where: { !$0.1 })?.0
    }

    mutating func nextWord() {
        guard targetWords?.isEmpty == false else { return }

        switch currentWord {
        case nil where !isCompleted:
            currentWord = targetWords?.first

        case let .some(currentWord) where currentWord == targetWords?.last:
            completedWords.append(currentWord)
            self.currentWord = nil

        case let .some(currentWord):
            guard let index = targetWords?.firstIndex(of: currentWord),
                  targetWords?.indices.contains(index + 1) == true else {
                break
            }

            completedWords.append(currentWord)
            self.currentWord = targetWords?[index + 1]

        default:
            break
        }
    }

    mutating func onLetterReceived(letter: String) {
        collectedLetters?.append(letter)

        guard let currentWordLetters,
              let index = currentWordLetters.firstIndex(where: { !$0.1 }),
              currentWordLetters[index].0 == letter else { return }

        self.currentWordLetters?[index].1 = true

        guard currentWordLetters.indices.contains(index + 1),
              currentWordLetters[index].0 == currentWordLetters[index + 1].0 else { return }

        self.currentWordLetters?[index + 1].1 = true
    }
}
