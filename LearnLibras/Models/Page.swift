//
//  Page.swift
//  LearnLibras
//
//  Created by Gustavo Batista on 16/09/24.
//

import SwiftUI

enum Page: View, CaseIterable {
    
    case intro, `try`

    var body: some View {
        switch self {
        case .intro:
            IntroView()
        case .try:
            TryView()

        }
    }
}
