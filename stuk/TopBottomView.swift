//
//  TopBottomView.swift
//  stuk
//
//  Created by Axel Langenskiöld on 2024-09-12.
//

import SwiftUI

struct TopBottomView: View {
    @State var isHome: Bool
    @State var isCalender: Bool
    @State var isCard: Bool
    @State var isTickets: Bool
    @State var isProfile: Bool
    
    @State var isRabatt: Bool
    
    
    var body: some View {
        
        ZStack {
            Rectangle()
                .frame(width: .infinity, height: .infinity)
                .foregroundStyle(.white)
        
//            top bar
        ZStack {
            Rectangle()
                .foregroundStyle(.white)
                .frame(width: .infinity, height: 230)
                .aspectRatio(contentMode: .fill)
                .shadow(radius: 1)
            
            Rectangle()
                .foregroundStyle(.white)
                .frame(width: .infinity, height: 155)
                .aspectRatio(contentMode: .fill)
                .shadow(radius: 1)
            
            HStack {
                VStack {
                    Text("Rabatter")
                        .bold()
                        .font(.custom("Arial", size: 17))
                    
                    Rectangle()
                        .foregroundColor(isRabatt ? .black : .white)
                        .frame(width: 90, height: 2)
                }
                .padding(.horizontal, 50)
                
                Spacer()
                
                VStack {
                    Text("Lokalt")
                        .bold()
                        .font(.custom("Arial", size: 17))
                    
                    Rectangle()
                        .foregroundColor(isRabatt ? .white : .black)
                        .frame(width: 90, height: 2)
                }
                .padding(.horizontal, 50)
            }
            .padding(.top, 201)
            
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
                Image(isHome ? "home_black" : "home_grey")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .clipped()
                    .padding(14)
                
                Image(isCalender ? "calender_black" : "calender_grey")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .clipped()
                    .padding(14)
                
                Image("card_grey")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .clipped()
                    .padding(14)
                
                Image(isTickets ? "tickets_black" : "tickets_grey")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .clipped()
                    .padding(14)
                
                Image(isProfile ? "profile_black" : "profile_grey")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .clipped()
                    .padding(14)
            }
            .padding(.top, 720)
        }
    }
}

#Preview {
    TopBottomView(isHome: true, isCalender: false, isCard: false, isTickets: false, isProfile: false, isRabatt: false)
}
