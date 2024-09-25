//
//  ColorExtension.swift
//  LearnLibras
//
//  Created by Gustavo Batista on 17/09/24.
//

import SwiftUI

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.currentIndex = hex.startIndex
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let red = Double((rgbValue & 0xff0000) >> 16) / 255
        let green = Double((rgbValue & 0x00ff00) >> 8) / 255
        let blue = Double(rgbValue & 0x0000ff) / 255
        
        self.init(red: red, green: green, blue: blue)
    }
}
