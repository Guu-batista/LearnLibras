//
//  IntroView.swift
//  LearnLibras
//
//  Created by Gustavo Batista on 17/09/24.
//

import SwiftUI

struct IntroView: View {

    @EnvironmentObject var navigationManager: NavigationManager
    @State var isAnimated: Bool = false

    var body: some View {
        GeometryReader { geo in
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Image("LLlogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width * (isAnimated ? 0.5 : 0.875))
                    Spacer()
                }
                if isAnimated {
                    Spacer()
                    NavigationButtonsView
                        .next("Começar")
                }
                Spacer()
            }
        }
        .animation(.linear(duration: 0.75), value: isAnimated)
        .animate(isAnimated: $isAnimated, wait: .seconds(1))
    }
}
