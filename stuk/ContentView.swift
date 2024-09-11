import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    var body: some View {
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
                                AdCard(image: "storytel", bottomColor: .green, bottomText: "skolstart", addText: "Upp till 10% rabatt", companyLogo: "storytel_logo")
                                AdCard(image: "apple", bottomColor: .green, bottomText: "skolstart", addText: "Upp till 10% rabatt", companyLogo: "apple_logo")
                            }       // Add horizontal padding if needed
                        }
                        .frame(maxWidth: 380)
                    }
                    
                    
                    
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
                                AdCard(image: "storytel", bottomColor: .green, bottomText: "skolstart", addText: "Upp till 10% rabatt", companyLogo: "storytel_logo")
                                AdCard(image: "apple", bottomColor: .green, bottomText: "skolstart", addText: "Upp till 10% rabatt", companyLogo: "apple_logo")
                            }       // Add horizontal padding if needed
                        }
                        .frame(maxWidth: 380)
                    }
                    
                    
                    
                    
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
                                AdCard(image: "storytel", bottomColor: .green, bottomText: "skolstart", addText: "Upp till 10% rabatt", companyLogo: "storytel_logo")
                                AdCard(image: "apple", bottomColor: .green, bottomText: "skolstart", addText: "Upp till 10% rabatt", companyLogo: "apple_logo")
                            }       // Add horizontal padding if needed
                        }
                        .frame(maxWidth: 380)
                    }
                    
                    
                    
                    
                    
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
                                AdCard(image: "storytel", bottomColor: .green, bottomText: "skolstart", addText: "Upp till 10% rabatt", companyLogo: "storytel_logo")
                                AdCard(image: "apple", bottomColor: .green, bottomText: "skolstart", addText: "Upp till 10% rabatt", companyLogo: "apple_logo")
                            }       // Add horizontal padding if needed
                        }
                        .frame(maxWidth: 380)
                    }
                }
            }
            .padding(.top, 220)
            
            
//            top bar
            ZStack {
                Rectangle()
                    .foregroundStyle(.white)
                    .frame(width: .infinity, height: 200)
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
                .padding(.top, 130)
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
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
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
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
