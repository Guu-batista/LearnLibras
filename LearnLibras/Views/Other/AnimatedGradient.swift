//
//  AnimatedGradient.swift
//  LearnLibras
//
//  Created by Gustavo Batista on 16/09/24.
//

import SwiftUI

struct AnimatedGradient: View {

    @State var secondGradientOpacity: CGFloat = 0.1

    var firstGradient: [Color]
    var secondGradient: [Color]

    var body: some View {
        ZStack {
            LinearGradient(
                colors: firstGradient,
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            LinearGradient(
                colors: secondGradient,
                startPoint: .topTrailing,
                endPoint: .bottomLeading
            )
            .opacity(secondGradientOpacity)
        }
        .onAppear(perform: colorAnimation)
    }
}

private extension AnimatedGradient {

    func colorAnimation() {
        let animation: Animation = .linear(duration: 5.0)
            .delay(1.0)
            .repeatForever(autoreverses: true)

        withAnimation(animation) {
            secondGradientOpacity = 0.1
            secondGradientOpacity = 0.5
            secondGradientOpacity = 0.5
            secondGradientOpacity = 0.9
        }
    }
}

struct AnimatedGradient_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedGradient(
            firstGradient: [.blue, .red],
            secondGradient: [.purple, .green]
        )
    }
}
