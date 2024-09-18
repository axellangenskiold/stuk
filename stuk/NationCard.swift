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
    @Binding var circle: Int
    
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.white)
                .frame(width: 378, height: 378*1.6)
                .overlay() {
                    ZStack {
                        if !isFake {
                            Image(image())
                                .resizable()
                                .scaledToFill()
                                .frame(width: 378, height: 378*1.6)
                                .clipped()
                                .clipShape(RoundedCorner(radius: 10))
                        } else {
                            Image(imageBack())
                                .resizable()
                                .scaledToFill()
                                .frame(width: 378, height: 378*1.6)
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
    
    private func image() -> String {
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
        switch circle {
        case 1:
            return "malmocard_back"
        case 2:
            return "nationcard_back"
        case 3:
            return "studentlundcard_back"
        default:
            return "defaultcard_back" // Add a default case to handle other values
        }
    }
}

#Preview {
    NationCard(circle: .constant(0))
}
