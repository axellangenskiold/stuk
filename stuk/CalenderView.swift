//
//  CalenderVie.swift
//  stuk
//
//  Created by Axel Langenskiöld on 2024-09-12.
//

import SwiftUI

struct CalenderView: View {
    @Binding var path: NavigationPath
    
    @State var isHome: Bool = false
    @State var isCalender: Bool = true
    @State var isCard: Bool = false
    @State var isTickets: Bool = false
    @State var isProfile: Bool = false
    @State var isRabatt: Bool = true
    
    var body: some View {
        NavigationView {
            ZStack {
                Rectangle()
                    .frame(width: .infinity, height: .infinity)
                    .foregroundStyle(.white)
                VStack {
                    HStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundStyle(.gray)
                                .frame(width: 100, height: 30)
                                .padding(.leading, 15)
                            
                            
                            Text("Lund")
                                .font(.custom("Arial", size: 15))
                        }
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundStyle(.gray)
                                .frame(width: 100, height: 30)
                            
                            
                            Text("Datum")
                                .font(.custom("Arial", size: 15))
                        }
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundStyle(.gray)
                                .frame(width: 100, height: 30)
                            
                            
                            Text("Filter")
                                .font(.custom("Arial", size: 15))
                        }
                        
                        Spacer()
                    } //Grey circles
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack {
                            CalenderCard(image: "kryckans", event: "Kryckans Hörna", nation: "Malmö Nation")
                            CalenderCard(image: "afternoontea", event: "Afternoon Tea", nation: "Helsingkrona Nation")
                            CalenderCard(image: "tapas", event: "Tapas Torsdag", nation: "Västgöta Nation")
                            CalenderCard(image: "torsdagspuben", event: "Torsdagspuben på Sydskånska", nation: "Sydskånska nation")
                            CalenderCard(image: "downtown", event: "DOWNTOWN", nation: "Östgöta Nation")
                            CalenderCard(image: "novishperiod", event: "Novishnollning", nation: "Malmö Nation")
                        }
                    }
                }
                .padding(.top, 120)
                .frame(maxHeight: 800)
                
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
                            Text("Evenemang")
                                .bold()
                                .font(.custom("Arial", size: 16))
                            
                            Rectangle()
                                .foregroundColor(isRabatt ? .black : .white)
                                .frame(width: 90, height: 2)
                        }
                        .padding(.horizontal, 50)
                        
                        Spacer()
                        
                        VStack {
                            Text("Utforska")
                                .bold()
                                .font(.custom("Arial", size: 16))
                            
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
                        
                        Button(action: {
                            var transaction = Transaction()
                            transaction.disablesAnimations = true
                            withTransaction(transaction) {
                                while path.count > 1 {
                                    path.removeLast()
                                }
                            }
                            
                        }) {
                            Image(isHome ? "home_black" : "home_grey")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 40, height: 40)
                                .clipped()
                                .padding(14)
                        }
                        
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
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    CalenderView(path: .constant(NavigationPath()))
}
