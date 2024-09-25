//
//  NavigationManager.swift
//  LearnLibras
//
//  Created by Gustavo Batista on 16/09/24.
//

import SwiftUI

@MainActor class NavigationManager: ObservableObject {
    @Published var pageIndex: Int = 0
}
extension NavigationManager {

    var page: Page {
        Page.allCases[pageIndex]
    }

    func navigateToNext() {
        if Page.allCases.indices.contains(pageIndex + 1) {
            pageIndex += 1
        }
    }

    func navigateToPrevius() {
        if Page.allCases.indices.contains(pageIndex - 1) {
            pageIndex -= 1
        }
    }
}
