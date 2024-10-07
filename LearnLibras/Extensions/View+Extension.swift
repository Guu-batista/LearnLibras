//
//  View+Extension.swift
//  LearnLibras
//
//  Created by Gustavo Batista on 16/09/24.
//

import SwiftUI

extension View {

    func animate(
        isAnimated: Binding<Bool>,
        wait duration: Duration
    ) -> some View {
        self
            .onAppear {
                Task { @MainActor in
                    try? await Task.sleep(for: duration)
                    isAnimated.wrappedValue = true
                }
            }
            .onDisappear {
                isAnimated.wrappedValue = false
            }
    }

    func moveEffect(
        animation: Animation = .default,
        isAnimated: Bool,
        x: CGFloat = 0,
        y: CGFloat = 15
    ) -> some View {
        self
            .offset(x: isAnimated ? 0 : x, y: isAnimated ? 0 : y)
            .opacity(isAnimated ? 1 : 0)
            .animation(animation, value: isAnimated)
    }
}
