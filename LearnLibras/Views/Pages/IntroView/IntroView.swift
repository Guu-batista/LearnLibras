//
//  IntroView.swift
//  LearnLibras
//
//  Created by Gustavo Batista on 17/09/24.
//

import SwiftUI

// MARK: - IntroView

struct IntroView: View {

    // MARK: Properties

    @EnvironmentObject var navigationManager: NavigationManager
    @State var isAnimated: Bool = false

    // MARK: View

    var body: some View {
        bodyView
            .animation(.linear(duration: 0.75), value: isAnimated)
            .animate(isAnimated: $isAnimated, wait: .seconds(1))
    }
}

// MARK: - Preview

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView()
            .setupPreview()
    }
}
