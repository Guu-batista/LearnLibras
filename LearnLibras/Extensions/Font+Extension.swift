//
//  Font+Extension.swift
//  LearnLibras
//
//  Created by Gustavo Batista on 16/09/24.
//

import SwiftUI

extension Font {

    // MARK: Properties

    static let custom: CustomFonts = .init()

    // MARK: CustomFonts

    struct CustomFonts {

        // MARK: Properties

        let largeTitle: Font = .system(size: 75)
        let largeTitle2: Font = .system(size: 50)
        let largeTitle2Rounded: Font = .system(size: 50, weight: .semibold, design: .rounded)

        let title: Font = .largeTitle
        let title2: Font = .title

        let body: Font = .title2
        let body2: Font = .title3

        let pageTitle: Font = .system(size: 50).weight(.bold)
        let letter: Font = .system(size: 75).weight(.medium)
        let logoTitle: Font = .system(size: 100).weight(.bold)
    }
}
