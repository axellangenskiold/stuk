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
    let durationDelay : CGFloat = 0.15
    
    var body: some View {
        NavigationView {
            ZStack {
                MovingBackground()
            
                VStack {
                    Spacer()
                    ZStack {
                        FlipableCardView(degree: $frontDegree, isFake: false)
                        FlipableCardView(degree: $backDegree, isFake: true)
                    }
                    .onTapGesture {
                        flipCard()
                    }
                    
                }
                
                
                VStack {
                    Spacer()
                    
                    HStack {
                        Text("Stäng")
                            .foregroundStyle(.white)
                            .font(.custom("Arial", size: 22))
                            .padding(.trailing, 60)
                        
                        ZStack {
                            Circle()
                                .frame(width: 35)
                                .foregroundStyle(.white)
                            
                            Text("1")
                            
                        }
                        
                        ZStack {
                            Circle()
                                .frame(width: 32)
                                .foregroundStyle(.black)
                            
                            Text("2")
                                .foregroundStyle(.white)
                            
                        }
                        
                        Image("qr")
                            .resizable()
                            .frame(width: 29, height: 29)
                            .padding(.leading, 60)
                        
                        Image("refresh")
                            .resizable()
                            .frame(width: 30, height: 35)
                    }
                }
            }
            .navigationBarHidden(true)
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
