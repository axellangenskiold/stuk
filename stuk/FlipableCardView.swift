//
//  FlipableCardView.swift
//  stuk
//
//  Created by Axel Langenskiöld on 2024-09-12.
//

import SwiftUI

struct FlipableCardView: View {
    @Binding var degree: Double
    var isFake: Bool
    
    var body: some View {
        NationCard(isFake: isFake)
        .rotation3DEffect(
            Angle(degrees: degree),
            axis: /*@START_MENU_TOKEN@*/(x: 0.0, y: 1.0, z: 0.0)/*@END_MENU_TOKEN@*/
        )
    }
}

#Preview {
    FlipableCardView(degree: .constant(180), isFake: true)
}
