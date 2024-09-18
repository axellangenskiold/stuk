//
//  TicketCard.swift
//  stuk
//
//  Created by Axel Langenskiöld on 2024-09-18.
//

import SwiftUI

struct TicketCard: View {
    @State var image: String
   
    var body: some View {
        ZStack {
            HStack {
                Image(image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipped()
                
                VStack(alignment: .leading) {
                    Text(image)
                        .bold()
                        .font(.custom("Arial", size: 25))
                        .padding(.bottom, 5)
                    
                    Text("30 dagar gratis + 50% studentrabatt")
                        .font(.custom("Arial", size: 11))
                        .padding(.bottom, 16)
                    
                    Text("Gäller till den 30 sep. 2024")
                        .font(.custom("Arial", size: 10))
                        .foregroundStyle(.gray)
                }
                .padding(.leading, 5)
                
                ZStack {
                    Rectangle()
                        .frame(width: 50, height: 100)
                        .foregroundStyle(.pink)
                    
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.white)
                }
                
            }
            .frame(width: 380, height: 150)
            
        }
        .frame(width: 380, height: 150)
    }
}

#Preview {
    TicketCard(image: "ica")
}
