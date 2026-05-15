//
//  NearbyView.swift
//  stuk
//

import SwiftUI

struct NearbyView: View {
    @Binding var path: NavigationPath

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
                        Spacer(minLength: 120)
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
                cityCard("Stockholm", color: Color(red: 0.50, green: 0.30, blue: 0.40))
                cityCard("Göteborg", color: Color(red: 0.55, green: 0.65, blue: 0.75))
                cityCard("Lund", color: Color(red: 0.65, green: 0.30, blue: 0.20))
            }
            .padding(.horizontal, 16)
        }
    }

    private func cityCard(_ name: String, color: Color) -> some View {
        ZStack(alignment: .bottomLeading) {
            BrandImage(name: name.lowercased(), displayName: name, fallbackColor: color)
                .frame(width: 240, height: 160)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            Text(name)
                .foregroundStyle(.white)
                .font(.system(size: 20, weight: .heavy))
                .padding(12)
        }
    }

    private var promoCard: some View {
        ZStack(alignment: .bottom) {
            BrandImage(name: "pressbyran_promo", displayName: "Pressbyrån",
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
                .padding(.bottom, 18)
        }
        .padding(.horizontal, 16)
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
                DealCard(image: "cafe1", displayName: "MIGRANE", title: "20% studentrabatt",
                         fallbackColor: Color(red: 0.95, green: 0.85, blue: 0.30),
                         width: 220, height: 280, showTag: false)
                DealCard(image: "pressbyran_promo", displayName: "Pressbyrån", title: "Studentkaffe från 10 kr",
                         fallbackColor: Color(red: 0.65, green: 0.75, blue: 0.85),
                         width: 220, height: 280, showTag: false)
            }
            .padding(.horizontal, 16)
        }
    }
}

#Preview {
    NearbyView(path: .constant(NavigationPath()))
}
