//
//  NavigationButtonsView+Publics.swift
//  LearnLibras
//
//  Created by Gustavo Batista on 17/09/24.
//

import SwiftUI

extension NavigationButtonsView {}


extension NavigationButtonsView {
    struct ButtonView: View {

        @EnvironmentObject var navigationManager: NavigationManager
        @EnvironmentObject var cameraManager: CameraManager

        var isNext: Bool
        var title: LocalizedStringKey
        var systemImage: String
        var direction: LayoutDirection


        var body: some View {
            Button(action: onButtonTapped) {
                Label(title, systemImage: systemImage)
                    .labelStyle(NavigationLabelStyle(imageDirection: direction))
            }
        }

        func onButtonTapped() {
            guard cameraManager.runStatus != .loading else { return }
            
            Task {
                await cameraManager.stopCapture()

                if isNext {
                    navigationManager.navigateToNext()
                } else {
                    navigationManager.navigateToPrevius()
                }
            }
        }
    }
}
