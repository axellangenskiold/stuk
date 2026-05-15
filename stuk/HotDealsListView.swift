//
//  HotDealsListView.swift
//  stuk
//

import SwiftUI

struct HotDealEntry {
    let image: String
    let displayName: String
    let title: String
    let fallback: Color
}

struct HotDealsListView: View {
    @Binding var path: NavigationPath

    private let deals: [HotDealEntry] = [
        .init(image: "samsung", displayName: "SAMSUNG", title: "50% studentrabatt", fallback: Color(red: 0.05, green: 0.18, blue: 0.05)),
        .init(image: "viaplay", displayName: "viaplay", title: "Viaplay Total - 50% studentrabatt i 3 måna…", fallback: Color(red: 0.32, green: 0.05, blue: 0.10)),
        .init(image: "lindex", displayName: "LINDEX", title: "25% rabatt", fallback: Color(red: 0.55, green: 0.70, blue: 0.85)),
        .init(image: "storytel", displayName: "storytel", title: "Prova gratis 45 dagar + 50% studentrabatt", fallback: Color(red: 0.20, green: 0.35, blue: 0.40)),
        .init(image: "makeupmekka", displayName: "Makeup Mekka", title: "20% studentrabatt", fallback: Color(red: 0.75, green: 0.55, blue: 0.75)),
        .init(image: "asus", displayName: "ASUS", title: "15% studentrabatt", fallback: Color.white),
        .init(image: "hm", displayName: "H&M", title: "10% studentrabatt", fallback: Color(white: 0.12)),
        .init(image: "rituals", displayName: "Rituals", title: "20% studentrabatt", fallback: Color(white: 0.12)),
    ]

    private let cols = [GridItem(.flexible(), spacing: 14), GridItem(.flexible(), spacing: 14)]

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 0) {
                headerBar
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: cols, spacing: 22) {
                        ForEach(0..<deals.count, id: \.self) { i in
                            let d = deals[i]
                            Button(action: { path.append(Destination.dealDetail) }) {
                                GridDealCard(image: d.image, displayName: d.displayName, title: d.title, fallbackColor: d.fallback)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 12)
                    .padding(.bottom, 120)
                }
            }

            VStack {
                Spacer()
                BottomTabBar(path: $path, current: .home)
            }
            .ignoresSafeArea(edges: .bottom)
        }
        .navigationBarBackButtonHidden(true)
    }

    private var headerBar: some View {
        ZStack {
            HStack(spacing: 6) {
                Text("Hot deals")
                    .foregroundStyle(.white)
                    .font(.system(size: 22, weight: .heavy))
                Text("🔥").font(.system(size: 22))
            }
            HStack {
                Button(action: { path.removeLast() }) {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.white)
                        .font(.system(size: 20, weight: .semibold))
                        .padding(.leading, 16)
                }
                Spacer()
            }
        }
        .padding(.vertical, 14)
    }
}

#Preview {
    HotDealsListView(path: .constant(NavigationPath()))
}
