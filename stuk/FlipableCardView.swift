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
    @Binding var circle: Int
    
    var body: some View {
        NationCard(isFake: isFake, circle: $circle)
        .rotation3DEffect(
            Angle(degrees: degree),
            axis: (x: 0.0, y: 1.0, z: 0.0)
        )
    }
}

#Preview {
    FlipableCardView(degree: .constant(180), isFake: true, circle: .constant(1))
}
