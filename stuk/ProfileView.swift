//
//  ProfileVie.swift
//  stuk
//
//  Created by Axel Langenskiöld on 2024-09-12.
//

import SwiftUI

struct ProfileView: View {
    @Binding var path: NavigationPath
    
    @State var isHome: Bool = false
    @State var isCalender: Bool = false
    @State var isCard: Bool = false
    @State var isTickets: Bool = false
    @State var isProfile: Bool = true
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: .infinity, height: .infinity)
                .foregroundStyle(.white)
            ScrollView {
                VStack {
                    ZStack {
                        Rectangle()
                            .frame(width: 400, height: 800)
                            .foregroundStyle(.bakegrey)
                            .padding(.bottom, 100)
                        
                        VStack {
                            ZStack {
                                Circle()
                                    .frame(width: 80)
                                    .foregroundStyle(.bakeblue)
                                
                                
                            }
                        }
                    }
                    
                }
            }
            
            
            
            
            //bottom bar
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
                    
                    Button(action: {
                        var transaction = Transaction()
                        transaction.disablesAnimations = true
                        withTransaction(transaction) {
                            path.append(Destination.ticketView)
                        }
                        
                    }) {
                        Image(isTickets ? "tickets_black" : "tickets_grey")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 40)
                            .clipped()
                            .padding(14)
                    }
                    
                    Image(isProfile ? "profile_black" : "profile_grey")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .clipped()
                        .padding(14)
                }
                .padding(.top, 720)
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
        }
    }
}

#Preview {
    ProfileView(path: .constant(NavigationPath()))
}
