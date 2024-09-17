//
//  AdCard.swift
//  stuk
//
//  Created by Axel Langenskiöld on 2024-09-11.
//

import SwiftUI

struct AdCard: View {
    @State var image: String
    @State var bottomColor: Color
    @State var bottomText: String
    @State var addText: String
    @State var companyLogo: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.white)
                .frame(width: 170, height: 220)
                .overlay() {
                    ZStack {
                        VStack {
                            Image(image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 170, height: 100)
                                .clipped()
                                .clipShape(RoundedCorner(radius: 10, corners: [.topLeft, .topRight]))
                            Spacer()
                            
                            Text(addText)
                                .foregroundStyle(.black)
                                .font(.custom("Arial", size: 16))
                                .bold()
                                .frame(maxWidth: 160)
                                .padding(.bottom, 5)
                            
                            ZStack {
                                Rectangle()
                                    .clipShape(RoundedCorner(radius: 10, corners: [.bottomLeft, .bottomRight]))
                                    .foregroundStyle(bottomColor)
                                Text(bottomText.uppercased(with: .autoupdatingCurrent))
                                    .foregroundStyle(.white)
                                    .font(.custom("Arial", size: 12))
                                    .bold()
                            }
                            .frame(width: 170, height: 22)
                        }
                        .frame(width: 170, height: 220)
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.white)
                                .frame(width: 70, height: 70)
                            Image(companyLogo)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 70, height: 70)
                                .clipped()
                                .clipShape(RoundedCorner(radius: 10, corners: [.topLeft, .topRight, .bottomLeft, .bottomRight]))
                            
                        }
                        .padding(.bottom, 20)
                        
                    }
                    .frame(width: 170, height: 22)
                }
        }
        .padding(2)
        .shadow(radius: 1)
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = 0
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

#Preview {
    AdCard(image: "Image", bottomColor: .green, bottomText: "skolstart", addText: "Upp till 10% studentrabatt", companyLogo: "Image")
}
