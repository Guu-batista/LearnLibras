//
//  LibrasView.swift
//  LearnLibras
//
//  Created by Gustavo Batista on 27/09/24.
//

import SwiftUI

struct LibrasView: View {
    @State var isAnimated: Bool = false
    let defaultAnimation: Animation = .easeIn.speed(0.5)

    var body: some View {
        VStack {
            Text("Sobre Libras")
                .foregroundColor(.black)
                .font(.system(size: 50, weight: .bold))
                .padding(.bottom, 20)
                .moveEffect(
                    animation: defaultAnimation,
                    isAnimated: isAnimated
                )

            GeometryReader { geo in
                VStack {
                    Text("Libras, ou Língua Brasileira de Sinais, é a língua oficial da comunidade surda no Brasil, reconhecida por lei desde 2002. Assim como qualquer outra língua, Libras tem sua própria gramática, vocabulário e estrutura. Ela não é apenas uma tradução do português, mas sim uma língua independente, com suas particularidades. Em vez de sons, Libras utiliza gestos feitos com as mãos, expressões faciais e movimentos corporais para formar palavras e transmitir ideias. Cada gesto em Libras é chamado de sinal, e esses sinais podem representar letras, palavras ou até frases inteiras. A comunicação acontece através da combinação de sinais que expressam conceitos, sentimentos e informações. Além das mãos, o rosto e o corpo desempenham um papel fundamental, pois a expressão facial pode mudar completamente o significado de um sinal. Aprender Libras é uma maneira poderosa de promover a inclusão e facilitar a comunicação entre surdos e ouvintes. Conhecer a língua de sinais não apenas permite a interação com pessoas surdas, mas também ajuda a criar uma sociedade mais inclusiva e consciente das necessidades de todos.")
                        .foregroundColor(.black)
                        .font(.title)
                    .multilineTextAlignment(.leading)
                    .padding()
                    .frame(maxWidth: geo.size.width * 1.0)
                    .moveEffect(
                        animation: defaultAnimation.delay(0.5),
                        isAnimated: isAnimated
                    )
                    Image("libras")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width * 0.6)
                        .padding(.top, 10)
                }
                .frame(width: geo.size.width)
                .padding()
                .moveEffect(
                    animation: defaultAnimation.delay(1.5),
                    isAnimated: isAnimated
                )
            }
            Spacer()
            NavigationButtonsView.both()
                .moveEffect(
                    animation: defaultAnimation.delay(2.0),
                    isAnimated: isAnimated
                )
        }
            .animate(isAnimated: $isAnimated, wait: .seconds(0.25))
    }
}

