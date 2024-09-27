//
//  LibrasView+UI.swift
//  LearnLibras
//
//  Created by Gustavo Batista on 27/09/24.
//

import SwiftUI

// MARK: - AboutSLView UI

extension LibrasView {

    var bodyView: some View {
        VStack {
            Text("Sobre Libras")
                .font(.custom.pageTitle)
                .moveEffect(
                    animation: defaultAnimation,
                    isAnimated: isAnimated
                )

            HStack {
                Text("AQUI UMA TEXASUOD OANSDUI ANSDIAUS NSDIAU NDIUA NDIUA NIDUNA IDUNA IUSN IUASN DISUAN IUSAN IUDSAN SIDAUN IUDAN DISAUN DIUA NIDU NAISUDNA IUAN UIASNDI AUNIU DNAIU DNSAIUD NAIUDNAIUNDIUA NDPDNLFAIH UBFHBFHBG OHB GFB GHFB GFHB HF BFBHBHBH FBHBH  BH HBBHBH HBFBGFHB GHF HBHFEBGI EBGFYEBFIBEUFBEUHBF EBF E IFF IE JFEIJ FIJE J IFIJEF IJEFJEFIJF EI JJI EJIJI  JIEIJJIEFIEJDIEJDUENDU NEUD ENND KNSDNSJKNDKJDSF KJ")
                .frame(minWidth: 500)
                .moveEffect(
                    animation: defaultAnimation.delay(0.5),
                    isAnimated: isAnimated
                )
            }
            Spacer()
            NavigationButtonsView.both()
                .moveEffect(
                    animation: defaultAnimation.delay(0.75),
                    isAnimated: isAnimated
                )
        }
    }

}
