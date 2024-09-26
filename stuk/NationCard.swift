//
//  NationCard.swift
//  stuk
//
//  Created by Axel Langenskiöld on 2024-09-12.
//

import SwiftUI

struct NationCard: View {
    @State var isFake: Bool = true
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
                            ZStack {
                                Image(imageBack())
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 378, height: 378*1.6)
                                    .clipped()
                                    .clipShape(RoundedCorner(radius: 10))
                                
                                
                                if (circle == 1) {
                                    VStack {
                                        HStack {
                                            VStack(alignment: .leading) {
                                                Text(Shared.shared.name)
                                                    .bold()
                                                    .font(.custom("Arial", size: 16))
                                                    .lineLimit(1)
                                                    .foregroundStyle(.black)
                                                
                                                Text(Shared.shared.personNbr)
                                                    .bold()
                                                    .font(.custom("Arial", size: 16))
                                                    .padding(.bottom, 11)
                                                    .foregroundStyle(.black)
                                                
                                                Text("GILTIGT TILL: 2024-12-31")
                                                    .bold()
                                                    .font(.custom("Arial", size: 12))
                                                    .lineLimit(1)
                                                    .foregroundStyle(.black)
                                            }
                                            .rotationEffect(.degrees(90))
                                            .padding(.top, 76)
                                            .padding(.leading, 5)
                                            
                                            Spacer()
                                        }
                                        .padding(0)
                                        
                                        Spacer()
                                    }
                                    .frame(width: 400, height: 378*1.6)
                                }
                            }
                            
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
    NationCard(circle: .constant(1))
}
