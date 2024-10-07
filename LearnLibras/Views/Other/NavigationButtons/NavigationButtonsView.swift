//
//  NavigationButtonsView.swift
//  LearnLibras
//
//  Created by Gustavo Batista on 17/09/24.
//

import SwiftUI

enum NavigationButtonsView: View {

    case next(_ title: LocalizedStringKey = "")
    case previus(_ title: LocalizedStringKey = "")
    case both(nextTitle: LocalizedStringKey = "Começar a aprender",
              previusTitle: LocalizedStringKey = "Voltar")


    var body: some View {
        bodyView
            .tint(.black)
    }

    @ViewBuilder var bodyView: some View {
        switch self {
        case let .next(title):
            nextButton(title: title)

        case let .previus(title):
            previusButton(title: title)

        case let .both(nextTitle, previusTitle):
            HStack {
                Spacer()
                previusButton(title: previusTitle)
                Spacer()
                nextButton(title: nextTitle)
                Spacer()
            }
        }
    }

    func nextButton(title: LocalizedStringKey) -> some View {
        ButtonView(isNext: true,
                   title: title,
                   systemImage: "chevron.right",
                   direction: .rightToLeft)
    }

    func previusButton(title: LocalizedStringKey) -> some View {
        ButtonView(isNext: false,
                   title: title,
                   systemImage: "chevron.left",
                   direction: .leftToRight)
    }
}
