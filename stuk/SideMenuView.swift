//
//  SideMenuView.swift
//  stuk
//

import SwiftUI

struct CategoryItem: Identifiable {
    let id = UUID()
    let title: String
    let symbol: String
}

struct SideMenuView: View {
    @Binding var isOpen: Bool
    var onSelect: (String) -> Void = { _ in }

    private let categories: [CategoryItem] = [
        .init(title: "Böcker & Kurslitteratur", symbol: "book"),
        .init(title: "Mobil & Bredband", symbol: "iphone"),
        .init(title: "Kläder & Mode", symbol: "tshirt"),
        .init(title: "Skönhet & Hudvård", symbol: "scissors"),
        .init(title: "Resor & Boende", symbol: "airplane"),
        .init(title: "TV & Streaming", symbol: "play.tv"),
        .init(title: "Smycken & Accessoarer", symbol: "diamond"),
        .init(title: "Sport & Träning", symbol: "soccerball"),
        .init(title: "Hälsa & Apotek", symbol: "cross.case"),
        .init(title: "Inredning & Hushåll", symbol: "shippingbox"),
        .init(title: "Matkassar & Livsmedel", symbol: "fork.knife.circle"),
        .init(title: "Bank & Försäkring", symbol: "banknote"),
        .init(title: "Datorer, Mjukvara & Teknik", symbol: "laptopcomputer"),
        .init(title: "Fest, Blommor & Nöje", symbol: "party.popper"),
    ]

    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.black.ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Kategorier")
                        .font(.system(size: 30, weight: .heavy))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 24)
                        .padding(.top, 80)
                        .padding(.bottom, 18)

                    ForEach(categories) { cat in
                        Button(action: { onSelect(cat.title) }) {
                            HStack(spacing: 18) {
                                Image(systemName: cat.symbol)
                                    .font(.system(size: 22, weight: .regular))
                                    .frame(width: 32, height: 32)
                                    .foregroundStyle(.white)
                                Text(cat.title)
                                    .foregroundStyle(.white)
                                    .font(.system(size: 19, weight: .semibold))
                                Spacer()
                            }
                            .padding(.horizontal, 24)
                            .padding(.vertical, 14)
                        }
                        .buttonStyle(.plain)
                    }
                    Spacer(minLength: 60)
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width * 0.85)
        .frame(maxHeight: .infinity)
    }
}

#Preview {
    SideMenuView(isOpen: .constant(true))
}
