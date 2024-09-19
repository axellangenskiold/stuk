//
//  TicketView.swift
//  stuk
//
//  Created by Axel Langenskiöld on 2024-09-12.
//

import SwiftUI

struct TicketView: View {
    @Binding var path: NavigationPath
    
    @State var isHome: Bool = false
    @State var isCalender: Bool = false
    @State var isCard: Bool = false
    @State var isTickets: Bool = true
    @State var isProfile: Bool = false
    @State var isRabatt: Bool = true
    
    var ads: [String] = ["apple", "hm", "ica", "jotex", "storytel", "sats", "rituals", "trygghansa"]
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: .infinity, height: .infinity)
                .foregroundStyle(.white)
            
            ScrollView { // Make content scrollable
                VStack {
                    ForEach(ads, id: \.self) { ad in
                        TicketCard(image: ad) // Use your TicketCard for each ad
                    }
                }
            }
            .frame(height: 600)
            
            //            top bar
            ZStack {
                Rectangle()
                    .foregroundStyle(.white)
                    .frame(width: .infinity, height: 230)
                    .aspectRatio(contentMode: .fill)
                    .shadow(radius: 1)
                    .opacity(0)
                
                Rectangle()
                    .foregroundStyle(.white)
                    .frame(width: .infinity, height: 155)
                    .aspectRatio(contentMode: .fill)
                    .shadow(radius: 1)

                
                HStack {
                    Image("bars")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .clipped()
                    
                    Spacer()
                    
                    Image("stuk")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 40)
                        .clipped()
                    
                    Spacer()
                    
                    Image("search")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                        .clipped()
                }
                .padding(.top, 105)
                .padding(.horizontal, 10)
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.bottom, 820)
            //
            //            // bottom bar
            ZStack {
                Rectangle()
                    .foregroundStyle(.white)
                    .frame(width: .infinity, height: 200)
                    .aspectRatio(contentMode: .fill)
                    .padding(.top, 860)
                    .shadow(radius: 1)
                
                HStack {
                    
                    Button(action: {
                        var transaction = Transaction()
                        transaction.disablesAnimations = true
                        withTransaction(transaction) {
                            path.removeLast()
                        }
                        
                    }) {
                        Image(isHome ? "home_black" : "home_grey")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 40)
                            .clipped()
                            .padding(14)
                    }
                    
                    Button(action: {
                        var transaction = Transaction()
                        transaction.disablesAnimations = true
                        withTransaction(transaction) {
                            path.append(Destination.calenderView)
                        }
                        
                    }) {
                        Image(isCalender ? "calender_black" : "calender_grey")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 40)
                            .clipped()
                            .padding(14)
                    }
                    
                    Button(action: {
                        var transaction = Transaction()
                        transaction.disablesAnimations = true
                        withTransaction(transaction) {
                            path.append(Destination.cardView)
                        }
                        
                    }) {
                        Image("card_grey")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 40)
                            .clipped()
                            .padding(14)
                    }
                    
                    Image(isTickets ? "tickets_black" : "tickets_grey")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .clipped()
                        .padding(14)
                    
                    Button(action: {
                        var transaction = Transaction()
                        transaction.disablesAnimations = true
                        withTransaction(transaction) {
                            path.append(Destination.profileView)
                        }
                        
                    }) {
                        Image(isProfile ? "profile_black" : "profile_grey")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 40)
                            .clipped()
                            .padding(14)
                    }
                }
                .padding(.top, 720)
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    TicketView(path: .constant(NavigationPath()))
}
