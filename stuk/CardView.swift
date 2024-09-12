//
//  CardView.swift
//  stuk
//
//  Created by Axel Langenskiöld on 2024-09-12.
//

import SwiftUI

struct CardView: View {
    @Binding var path: NavigationPath
    
    @State private var isFlipped = true
    @State var frontDegree = 0.0
    @State var backDegree = -90.0
    let durationDelay : CGFloat = 0.3
    
    var body: some View {
        ZStack {
            MovingBackground()
            
            ZStack {
                FlipableCardView(degree: $frontDegree, isFake: false)
                FlipableCardView(degree: $backDegree, isFake: true)
            }
            .padding(.top, 41)
            .onTapGesture {
                flipCard()
            }
        }
    }
    
    func flipCard() {
        isFlipped = !isFlipped
        if !isFlipped {
            withAnimation(.linear(duration: durationDelay)) {
                frontDegree = 90
            }
            withAnimation(.linear(duration: durationDelay)
                .delay(durationDelay)) {
                    backDegree = 0
                }
            
        }
        else {
            withAnimation(.linear(duration: durationDelay)) {
                backDegree = -90
            }
            withAnimation(.linear(duration: durationDelay)
                .delay(durationDelay)) {
                    frontDegree = 0
                }
        }
    }
    
}

#Preview {
    CardView(path: .constant(NavigationPath()))
}
