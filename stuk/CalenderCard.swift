//
//  CalenderCard.swift
//  stuk
//
//  Created by Axel Langenskiöld on 2024-09-12.
//

import SwiftUI

struct CalenderCard: View {
    @State var image: String
    @State var event: String
    @State var nation: String
    
    @State var dates: [String] = [
        "12 SEP 09.00 - 12 SEP 19.00",
        "05 OCT 14.30 - 06 OCT 01.00",
        "23 NOV 16.00 - 24 NOV 02.00",
        "17 JUL 18.15 - 18 JUL 04.00",
        "29 AUG 08.00 - 29 AUG 17.00",
        "02 DEC 20.00 - 03 DEC 06.00",
        "08 JUN 13.45 - 09 JUN 00.30",
        "14 FEB 07.00 - 14 FEB 15.00",
        "31 MAY 19.30 - 01 JUN 05.00",
        "18 OCT 11.00 - 18 OCT 20.00",
        "27 JAN 22.00 - 28 JAN 07.00",
        "10 MAR 12.30 - 10 MAR 22.00",
        "22 APR 15.00 - 22 APR 23.00",
        "19 AUG 10.45 - 19 AUG 18.00",
        "06 NOV 21.00 - 07 NOV 06.00",
        "03 DEC 06.15 - 03 DEC 14.45"
        ]
    
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.white)
                .frame(width: 360, height: 240)
                .shadow(radius: 1)
                .overlay() {
                    VStack {
                        Image(image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 360, height: 180)
                            .clipped()
                            .clipShape(RoundedCorner(radius: 10, corners: [.topLeft, .topRight]))
                        HStack {
                            VStack(alignment: .leading, content: {
                                Text(dates.randomElement()!)
                                    .foregroundStyle(.gray)
                                    .font(.custom("Arial", size: 10))
                                
                                Text(event)
                                    .font(.custom("Arial", size: 14))
                                    .bold()
                                
                                Text(nation)
                                    .foregroundStyle(.gray)
                                    .font(.custom("Arial", size: 10))
                            })
                            .padding(.leading, 10)
                            Spacer()
                        }
                        .padding(.vertical, 5)
                    }
                }
        }
    }
}

#Preview {
    CalenderCard(image: "kryckans", event: "Kryckans Hörna", nation: "Malmö Nation")
}
