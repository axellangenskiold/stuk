//
//  NationCard.swift
//  stuk
//
//  Created by Axel Langenskiöld on 2024-09-12.
//

import SwiftUI

struct NationCard: View {
    @State var isFake: Bool = false
    @State var rotation: CGFloat = 0.0
    @State var circle: Int
    
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.white)
                .frame(width: 380, height: 380*1.6)
                .overlay() {
                    ZStack {
                        if !isFake {
                            Image("nationcard")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 380, height: 380*1.6)
                                .clipped()
                                .clipShape(RoundedCorner(radius: 10))
                        } else {
                            Image("nationcard_back")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 380, height: 380*1.6)
                                .clipped()
                                .clipShape(RoundedCorner(radius: 10))
                        }
                    }
                }
                .shadow(radius: 1)
        }
        .onAppear{
            withAnimation(.linear(duration: 2.0).repeatForever(autoreverses: false)) {
                rotation = 360
            }
        }
    }
    
    private func image(for circle: Int) -> String {
        switch circle {
        case 1:
            return "malmocard"
        case 2:
            return "nationcard"
        case 3:
            return "studentlundcard"
        default:
            return "defaultcard" // Add a default case to handle other values
        }
    }
    
    private func imageBack() -> String {
        return ""
    }
}

#Preview {
    NationCard(circle: 0)
}
