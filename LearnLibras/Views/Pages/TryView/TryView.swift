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
            VStack {
                Spacer()
                Text("LearnLibras")
                    .font(.custom.pageTitle)
                    .moveEffect(
                        animation: defaultAnimation,
                        isAnimated: isAnimated
                    )
                Spacer()
                    GeometryReader { geo in
                        HStack {
                            HandDetectorView(wordValue: $wordValue)
                                .moveEffect(
                                    animation: defaultAnimation.delay(0.75),
                                    isAnimated: isAnimated
                                )
                                VStack {
                                    Text("Escolha uma letra para aprender!")
                                        .frame(maxWidth: .infinity)
                                        .font(.custom.body)
                                        .padding()
                                        .cornerRadius(10)
                                      
                                    
                                    VStack {
                                        if let selectedLetter {
                                            letterView(for: selectedLetter)
                                        } else {
                                            ScrollView(showsIndicators: false) {
                                                LazyVGrid(columns: [.init(), .init(), .init()]) {
                                                    ForEach(letters, id: \.self) { letter in
                                                        Button(letter) {
                                                            selectedLetter = letter
                                                        }
                                                        .font(.custom.letter)
                                                        .foregroundColor(.white)
                                                        .matchedGeometryEffect(id: letter, in: namespace)
                                                        .padding()
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    .frame(maxWidth: .infinity)
                                    .animation(.easeInOut, value: selectedLetter)

                                        .padding()
                                        .cornerRadius(10)
                                        .animation(.easeInOut, value: wordValue.currentLetter)
                                        .animation(.easeInOut, value: selectedLetter)
                                        .moveEffect(
                                            animation: defaultAnimation.delay(0.5),
                                            isAnimated: isAnimated
                                        )
                                }
                                .frame(width: geo.size.width / 3)

                            
                        }
                    }
                    .padding()
                Spacer()
            }
            .animate(isAnimated: $isAnimated, wait: .seconds(0.25))
    }
    
    func letterView(for letter: String) -> some View {
        VStack {
            Text(letter)
                .font(.custom.letter)
                .matchedGeometryEffect(id: letter, in: namespace)
                .frame(maxWidth: .infinity)
                .background(alignment: .topLeading) {
                    Button {
                        selectedLetter = nil
                    } label: {
                        Label("Voltar", systemImage: "chevron.left")
                    }

                }

            Spacer()

            letterImageView(letter.lowercased())
                .opacity(selectedLetter == letter ? 1 : 0)

            Spacer()
        }
    }

    func letterImageView(_ name: String) -> some View {
        Image(name)
            .resizable()
            .scaledToFit()
    }
}
