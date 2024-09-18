//
//  TicketCard.swift
//  stuk
//
//  Created by Axel Langenskiöld on 2024-09-18.
//

import SwiftUI

struct TicketCard: View {
    @State var image: String
    
    var ads: [String] = ["apple", "hm", "ica", "jotex", "storytel", "sats"]
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
                    
                    Text("30 dagar gratis + 50% studentrabatt")
                    
                    Text("Gäller till den 30 sep. 2024")
                }
                
            }
            .frame(width: 380, height: 150)
            .shadow(radius: 5)
            
        }
        .frame(width: 380, height: 150)
    }
}

#Preview {
    TicketCard(image: "ica")
}
