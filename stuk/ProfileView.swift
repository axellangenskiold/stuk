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
                .foregroundStyle(.bakegrey)
            
            ScrollView {
                VStack {
                    ZStack {
                        Rectangle()
                            .frame(width: 400, height: 300)
                            .foregroundStyle(.bakegrey)
                        
                        VStack {
                            ZStack {
                                Circle()
                                    .frame(width: 80)
                                    .foregroundStyle(.bakeblue)
                                
                                Text(Shared.shared.initials)
                                    .bold()
                                    .foregroundStyle(.bakerblue)
                                    .font(.custom("Arial", size: 30))
                            }
                            .padding(.bottom, 30)
                            
                            Text(Shared.shared.name)
                                .bold()
                                .font(.custom("Arial", size: 20))
                                .foregroundStyle(.black)
                                .padding(.bottom, 5)
                            
                            Text(Shared.shared.email)
                                .font(.custom("Arial", size: 12))
                                .foregroundStyle(.gray)
                                .padding(.bottom, 20)
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 15)
                                    .foregroundStyle(.black)
                                    .frame(width: 160, height: 30)
                                
                                
                                Text("Redigera profil")
                                    .bold()
                                    .font(.custom("Arial", size: 15))
                                    .foregroundStyle(.white)
                            }
                        }
                    }
                    
                    ZStack {
                        Rectangle()
                            .frame(width: 400, height: 600)
                            .foregroundStyle(.white)
                            .padding(.bottom, 60)
                        VStack {
                            HStack {
                                Text("Mina medlemskap")
                                    .bold()
                                    .foregroundStyle(.black)
                                    .font(.custom("Arial", size: 20))
                                    .padding(.leading, 10)
                                
                                Spacer()
                            }
                            
                            Image("profilecard")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 380, height: 200)
                                .clipped()
                                .clipShape(RoundedCorner(radius: 10, corners: .allCorners))
                            
                            Image("profilecard2")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 380, height: 200)
                                .clipped()
                                .clipShape(RoundedCorner(radius: 10, corners: .allCorners))
                        }
                        .padding(.bottom, 200)
                    }
                    
                }
            }
            .frame(width: 400, height: 700)
            
            VStack {
                HStack {
                    Button(action: {
                        path.append(Destination.setNameView)
                    }, label: {
                        Image(systemName: "gear")
                            .font(.title2)
                            .bold()
                            .padding(.leading, 30)
                            .foregroundStyle(.black)
                    })
                    
                    Spacer()
                    
                    Image(systemName: "ticket")
                        .font(.title2)
                        .bold()
                        .padding(.trailing, 30)
                        .foregroundStyle(.black)
                }
                .padding(.bottom, 750)
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
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ProfileView(path: .constant(NavigationPath()))
}
