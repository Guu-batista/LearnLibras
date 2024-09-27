//
//  NavigationLabelStyle.swift
//  LearnLibras
//
//  Created by Gustavo Batista on 17/09/24.
//

import SwiftUI

struct NavigationLabelStyle: LabelStyle {

    var imageDirection: LayoutDirection = .leftToRight
    
    func makeBody(configuration: Configuration) -> some View {
        contentView(configuration: configuration)
            .font(.custom.title2)
            .padding()
    }

    func contentView(configuration: Configuration) -> some View {
        HStack {
            switch imageDirection {
            case .leftToRight:
                configuration.icon
                configuration.title

            case .rightToLeft:
                configuration.title
                configuration.icon

            @unknown default:
                configuration.icon
                configuration.title
            }
        }
    }

    var borderView: some View {
        RoundedRectangle(cornerRadius: 10)
            .stroke(.white, lineWidth: 3)
    }
}

