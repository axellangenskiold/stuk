//
//  NearbyView.swift
//  stuk
//

import SwiftUI

private func pic(_ seed: String, _ w: Int = 600, _ h: Int = 800) -> String {
    "https://picsum.photos/seed/\(seed)/\(w)/\(h)"
}

struct NearbyView: View {
    @Binding var path: NavigationPath

    private let cities: [(name: String, seed: String, color: Color)] = [
        ("Stockholm", "stockholm-skyline", Color(red: 0.50, green: 0.30, blue: 0.40)),
        ("Göteborg", "goteborg-tram", Color(red: 0.55, green: 0.65, blue: 0.75)),
        ("Lund", "lund-brickhouse", Color(red: 0.65, green: 0.30, blue: 0.20)),
        ("Malmö", "malmo-square", Color(red: 0.30, green: 0.45, blue: 0.55)),
        ("Uppsala", "uppsala-old", Color(red: 0.50, green: 0.40, blue: 0.30)),
    ]

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 0) {
                headerBar
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 22) {
                        cityRow
                        promoCard
                        sectionHeader("Café & Restaurang")
                        cafeRow
                        sectionHeader("Kläder & Mode")
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 14) {
                                ForEach(DealStore.fashion) { d in
                                    Button(action: { path.append(Destination.dealDetail(d)) }) {
                                        DealCard(item: d, width: 220, height: 280)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                            .padding(.horizontal, 16)
                        }
                        Spacer(minLength: 140)
                    }
                    .padding(.top, 12)
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
            Text("I närheten")
                .foregroundStyle(.white)
                .font(.system(size: 18, weight: .heavy))
            HStack {
                Button(action: { path.removeLast() }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.white)
                        .frame(width: 42, height: 42)
                        .background(Circle().fill(Color.white.opacity(0.1)))
                        .padding(.leading, 16)
                }
                Spacer()
                Button(action: {}) {
                    Image(systemName: "map")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.white)
                        .frame(width: 42, height: 42)
                        .background(Circle().fill(Color.white.opacity(0.1)))
                        .padding(.trailing, 16)
                }
            }
        }
        .padding(.vertical, 14)
    }

    private var cityRow: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 14) {
                ForEach(0..<cities.count, id: \.self) { i in
                    let c = cities[i]
                    Button(action: { path.append(Destination.nearbyCity(c.name)) }) {
                        cityCard(c.name, seed: c.seed, color: c.color)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 16)
        }
    }

    private func cityCard(_ name: String, seed: String, color: Color) -> some View {
        ZStack(alignment: .bottomLeading) {
            BrandImage(url: pic(seed), displayName: name, fallbackColor: color)
                .frame(width: 240, height: 160)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            Text(name)
                .foregroundStyle(.white)
                .font(.system(size: 20, weight: .heavy))
                .shadow(radius: 2)
                .padding(12)
        }
    }

    private var promoCard: some View {
        let promoDeal = DealStore.popular.first(where: { $0.brand == "hallon" }) ?? DealStore.hotDeals[0]
        return Button(action: { path.append(Destination.dealDetail(promoDeal)) }) {
            ZStack(alignment: .bottom) {
                BrandImage(url: pic("pressbyran-cafe-promo"), displayName: "Pressbyrån",
                           fallbackColor: Color(red: 0.65, green: 0.75, blue: 0.85))
                    .frame(height: 360)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    .overlay(
                        LinearGradient(colors: [.clear, .black.opacity(0.25)],
                                       startPoint: .center, endPoint: .bottom)
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                    )
                Text("Studentkaffe från 10 kr")
                    .foregroundStyle(.white)
                    .font(.system(size: 20, weight: .heavy))
                    .shadow(radius: 2)
                    .padding(.bottom, 18)
            }
            .padding(.horizontal, 16)
        }
        .buttonStyle(.plain)
    }

    private func sectionHeader(_ title: String) -> some View {
        HStack {
            Text(title)
                .foregroundStyle(.white)
                .font(.system(size: 20, weight: .heavy))
            Spacer()
            Text("Visa alla")
                .underline()
                .foregroundStyle(.white)
                .font(.system(size: 14))
        }
        .padding(.horizontal, 16)
    }

    private var cafeRow: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 14) {
                ForEach(DealStore.health + DealStore.popular) { d in
                    Button(action: { path.append(Destination.dealDetail(d)) }) {
                        DealCard(item: d, width: 220, height: 280)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 16)
        }
    }
}

struct NearbyCityView: View {
    @Binding var path: NavigationPath
    let city: String

    private let cols = [GridItem(.flexible(), spacing: 14), GridItem(.flexible(), spacing: 14)]

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 0) {
                ZStack {
                    Text(city)
                        .foregroundStyle(.white)
                        .font(.system(size: 18, weight: .heavy))
                    HStack {
                        Button(action: { path.removeLast() }) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundStyle(.white)
                                .frame(width: 42, height: 42)
                                .background(Circle().fill(Color.white.opacity(0.1)))
                                .padding(.leading, 16)
                        }
                        Spacer()
                    }
                }
                .padding(.vertical, 14)

                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: cols, spacing: 18) {
                        ForEach(DealStore.hotDeals.shuffled().prefix(8) + DealStore.popular.shuffled().prefix(4)) { d in
                            Button(action: { path.append(Destination.dealDetail(d)) }) {
                                GridDealCard(item: d)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                    .padding(.bottom, 140)
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
}

#Preview {
    NearbyView(path: .constant(NavigationPath()))
}
