//
//  TryView.swift
//  LearnLibras
//
//  Created by Gustavo Batista on 17/09/24.
//

import SwiftUI

struct TryView: View {

    @State var isAnimated: Bool = false
    @State var wordValue: HandDetectorView.WordValue = .init()
    @State var selectedLetter: String? = nil

    @Namespace var namespace

    let defaultAnimation: Animation = .easeIn.speed(0.5)
    let letters: [String] = "ABCDEFGILMNOPQRSTUVWY".map({ String($0) })

    var isCompleted: Bool {
        (wordValue.collectedLetters?.count ?? 0) > 2
    }

    var body: some View {
        bodyView
            .animate(isAnimated: $isAnimated, wait: .seconds(0.25))
    }
}
