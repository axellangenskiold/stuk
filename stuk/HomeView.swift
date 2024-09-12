import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @State var path = NavigationPath()
    
    @State var isHome: Bool = true
    @State var isCalender: Bool = false
    @State var isCard: Bool = false
    @State var isTickets: Bool = false
    @State var isProfile: Bool = false
    @State var isRabatt: Bool = true
    
    
    
    @State var current: String = "home"

    var body: some View {
        NavigationStack {
            ZStack {
                Rectangle()
                    .frame(width: .infinity, height: .infinity)
                    .foregroundStyle(.white)
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        VStack {
                            HStack {
                                Text("Back to School 📚")
                                    .bold()
                                
                                Spacer()
                                
                                Text("Visa alla")
                                    .foregroundStyle(.pink)
                            }
                            .frame(maxWidth: 370)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(alignment: .bottom) { // Add spacing if needed
                                    AdCard(image: "storytel", bottomColor: .green, bottomText: "skolstart", addText: "Upp till 10% rabatt", companyLogo: "storytel_logo")
                                    AdCard(image: "apple", bottomColor: .green, bottomText: "skolstart", addText: "Upp till 10% rabatt", companyLogo: "apple_logo")
                                    AdCard(image: "trygghansa", bottomColor: .green, bottomText: "skolstart", addText: "Upp till 10% rabatt", companyLogo: "trygghansa_logo")
                                    AdCard(image: "sats", bottomColor: .green, bottomText: "skolstart", addText: "Upp till 10% rabatt", companyLogo: "sats_logo")
                                    AdCard(image: "jotex", bottomColor: .green, bottomText: "skolstart", addText: "Upp till 10% rabatt", companyLogo: "jotex_logo")
                                    AdCard(image: "hm", bottomColor: .green, bottomText: "skolstart", addText: "Upp till 10% rabatt", companyLogo: "hm_logo")
                                    AdCard(image: "rituals", bottomColor: .green, bottomText: "skolstart", addText: "Upp till 10% rabatt", companyLogo: "rituals_logo")
                                }       // Add horizontal padding if needed
                            }
                            .frame(maxWidth: 380)
                        }
                        .padding(.leading, 5)
                        
                        
                        
                        VStack {
                            HStack {
                                Text("Hot deals 🔥")
                                    .bold()
                                
                                Spacer()
                                
                                Text("Visa alla")
                                    .foregroundStyle(.pink)
                            }
                            .frame(maxWidth: 370)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(alignment: .bottom) { // Add spacing if needed
                                    AdCard(image: "sats", bottomColor: .blue, bottomText: "kampanj", addText: "Upp till 30% rabatt", companyLogo: "sats_logo")
                                    AdCard(image: "hm", bottomColor: .pink, bottomText: "tävling", addText: "Kampanj, 10% rabatt", companyLogo: "hm_logo")
                                    AdCard(image: "apple", bottomColor: .green, bottomText: "skolstart", addText: "10% studentrabatt", companyLogo: "apple_logo")
                                    AdCard(image: "jotex", bottomColor: .blue, bottomText: "kampanj", addText: "20% studentrabatt", companyLogo: "jotex_logo")
                                    AdCard(image: "rituals", bottomColor: .pink, bottomText: "tävling", addText: "Upp till 40% rabatt", companyLogo: "rituals_logo")
                                    AdCard(image: "trygghansa", bottomColor: .green, bottomText: "skolstart", addText: "Kampanj, 10% rabatt", companyLogo: "trygghansa_logo")
                                    AdCard(image: "storytel", bottomColor: .blue, bottomText: "kampanj", addText: "30% rabatt", companyLogo: "storytel_logo")
                                }       // Add horizontal padding if needed
                            }
                            .frame(maxWidth: 380)
                        }
                        .padding(.leading, 5)
                        
                        
                        
                        
                        VStack {
                            HStack {
                                Text("Populära rabatter")
                                    .bold()
                                
                                Spacer()
                                
                                Text("Visa alla")
                                    .foregroundStyle(.pink)
                            }
                            .frame(maxWidth: 370)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(alignment: .bottom) { // Add spacing if needed
                                    AdCard(image: "hm", bottomColor: .green, bottomText: "kampanj", addText: "20% studentrabatt", companyLogo: "hm_logo")
                                    AdCard(image: "storytel", bottomColor: .pink, bottomText: "tävling", addText: "Upp till 40% rabatt", companyLogo: "storytel_logo")
                                    AdCard(image: "apple", bottomColor: .blue, bottomText: "skolstart", addText: "30% rabatt", companyLogo: "apple_logo")
                                    AdCard(image: "jotex", bottomColor: .green, bottomText: "tävling", addText: "Kampanj, 10% rabatt", companyLogo: "jotex_logo")
                                    AdCard(image: "trygghansa", bottomColor: .blue, bottomText: "skolstart", addText: "Upp till 30% rabatt", companyLogo: "trygghansa_logo")
                                    AdCard(image: "sats", bottomColor: .pink, bottomText: "kampanj", addText: "10% studentrabatt", companyLogo: "sats_logo")
                                    AdCard(image: "rituals", bottomColor: .green, bottomText: "tävling", addText: "Upp till 40% rabatt", companyLogo: "rituals_logo")
                                }       // Add horizontal padding if needed
                            }
                            .frame(maxWidth: 380)
                        }
                        .padding(.leading, 5)
                        
                        
                        
                        
                        
                        VStack {
                            HStack {
                                Text("Studentrabatter för dig")
                                    .bold()
                                
                                Spacer()
                                
                                Text("Visa alla")
                                    .foregroundStyle(.pink)
                            }
                            .frame(maxWidth: 370)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(alignment: .bottom) { // Add spacing if needed
                                    AdCard(image: "apple", bottomColor: .pink, bottomText: "kampanj", addText: "Upp till 30% rabatt", companyLogo: "apple_logo")
                                    AdCard(image: "hm", bottomColor: .blue, bottomText: "tävling", addText: "30% rabatt", companyLogo: "hm_logo")
                                    AdCard(image: "storytel", bottomColor: .green, bottomText: "skolstart", addText: "10% studentrabatt", companyLogo: "storytel_logo")
                                    AdCard(image: "rituals", bottomColor: .blue, bottomText: "kampanj", addText: "Kampanj, 10% rabatt", companyLogo: "rituals_logo")
                                    AdCard(image: "trygghansa", bottomColor: .green, bottomText: "tävling", addText: "Upp till 40% rabatt", companyLogo: "trygghansa_logo")
                                    AdCard(image: "jotex", bottomColor: .pink, bottomText: "skolstart", addText: "Upp till 30% rabatt", companyLogo: "jotex_logo")
                                    AdCard(image: "sats", bottomColor: .blue, bottomText: "skolstart", addText: "20% studentrabatt", companyLogo: "sats_logo")
                                }       // Add horizontal padding if needed
                            }
                            .frame(maxWidth: 380)
                        }
                        .padding(.leading, 5)
                        
                        VStack {
                            HStack {
                                Text("Populärt just nu")
                                    .bold()
                                
                                Spacer()
                                
                                Text("Visa alla")
                                    .foregroundStyle(.pink)
                            }
                            .frame(maxWidth: 370)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(alignment: .bottom) { // Add spacing if needed
                                    AdCard(image: "jotex", bottomColor: .green, bottomText: "kampanj", addText: "10% studentrabatt", companyLogo: "jotex_logo")
                                    AdCard(image: "sats", bottomColor: .pink, bottomText: "tävling", addText: "Upp till 30% rabatt", companyLogo: "sats_logo")
                                    AdCard(image: "hm", bottomColor: .blue, bottomText: "skolstart", addText: "Kampanj, 10% rabatt", companyLogo: "hm_logo")
                                    AdCard(image: "apple", bottomColor: .green, bottomText: "tävling", addText: "20% studentrabatt", companyLogo: "apple_logo")
                                    AdCard(image: "trygghansa", bottomColor: .blue, bottomText: "kampanj", addText: "Upp till 40% rabatt", companyLogo: "trygghansa_logo")
                                    AdCard(image: "storytel", bottomColor: .pink, bottomText: "skolstart", addText: "30% rabatt", companyLogo: "storytel_logo")
                                    AdCard(image: "rituals", bottomColor: .green, bottomText: "tävling", addText: "Upp till 30% rabatt", companyLogo: "rituals_logo")
                                }       // Add horizontal padding if needed
                            }
                            .frame(maxWidth: 380)
                        }
                        .padding(.leading, 5)
                        
                        
                        
                        VStack {
                            HStack {
                                Text("Back to School 📚")
                                    .bold()
                                
                                Spacer()
                                
                                Text("Visa alla")
                                    .foregroundStyle(.pink)
                            }
                            .frame(maxWidth: 370)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(alignment: .bottom) { // Add spacing if needed
                                    AdCard(image: "storytel", bottomColor: .blue, bottomText: "tävling", addText: "Upp till 40% rabatt", companyLogo: "storytel_logo")
                                    AdCard(image: "hm", bottomColor: .green, bottomText: "kampanj", addText: "10% studentrabatt", companyLogo: "hm_logo")
                                    AdCard(image: "trygghansa", bottomColor: .pink, bottomText: "skolstart", addText: "20% studentrabatt", companyLogo: "trygghansa_logo")
                                    AdCard(image: "apple", bottomColor: .blue, bottomText: "kampanj", addText: "Upp till 30% rabatt", companyLogo: "apple_logo")
                                    AdCard(image: "sats", bottomColor: .green, bottomText: "tävling", addText: "Kampanj, 10% rabatt", companyLogo: "sats_logo")
                                    AdCard(image: "rituals", bottomColor: .pink, bottomText: "skolstart", addText: "Upp till 30% rabatt", companyLogo: "rituals_logo")
                                    AdCard(image: "jotex", bottomColor: .green, bottomText: "kampanj", addText: "30% rabatt", companyLogo: "jotex_logo")
                                }       // Add horizontal padding if needed
                            }
                            .frame(maxWidth: 380)
                        }
                        .padding(.leading, 5)
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
            .navigationDestination(for: Destination.self) { destination in
                switch destination {
                case .calenderView: CalenderView(path: $path)
                case .ticketView : TicketView(path: $path)
                case .cardView : CardView(path: $path)
                case .profileView : ProfileView(path: $path)
                case .homeView : HomeView()
                }
            }
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    //path: .constant(NavigationPath())
    HomeView()
        .modelContainer(for: Item.self, inMemory: true)
}
