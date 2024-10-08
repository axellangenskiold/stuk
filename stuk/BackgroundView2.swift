//
//  BackgroundView2.swift
//  stuk
//
//  Created by Axel Langenskiöld on 2024-10-08.
//

import SwiftUI

struct BackgroundView2: View {
    @State private var offsetX: CGFloat = 0
    @State private var offsetY: CGFloat = 0
    
    let stripeCount = 7
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.QQ_ORANGE
                    .ignoresSafeArea()
                
                ForEach(0..<stripeCount, id: \.self) { index in
                    Rectangle()
                        .fill(.white.opacity(Double.random(in: 0...0.07)))
                        .rotationEffect(.degrees(25.0))
                        .frame(width: CGFloat.random(in: 50...150), height: geometry.size.width * 8)
                        .offset(x: offsetX - CGFloat(index) * (geometry.size.width + 150) / CGFloat(stripeCount), y: CGFloat.random(in: -geometry.size.height...geometry.size.height))
                        .opacity(1)
                        .animation (
                            Animation.linear(duration: 30)
                                .repeatForever(autoreverses: true),
                            value: UUID()
                        )
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .onAppear {
                offsetX = geometry.size.width
                offsetY = geometry.size.height
            }
        }
    }
}



#Preview {
    BackgroundView2()
}

