//
//  DealCard.swift
//  stuk
//

import SwiftUI

/// Renders a brand image if it exists in the asset catalog,
/// otherwise falls back to a colored card with the brand name as a placeholder.
struct BrandImage: View {
    let name: String
    var displayName: String? = nil
    var fallbackColor: Color = Color(white: 0.13)
    var fontSize: CGFloat = 26

    var body: some View {
        if UIImage(named: name) != nil {
            Image(name)
                .resizable()
                .scaledToFill()
        } else {
            ZStack {
                fallbackColor
                Text((displayName ?? name).uppercased())
                    .font(.system(size: fontSize, weight: .heavy, design: .default))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .padding(8)
            }
        }
    }
}

struct KampanjTag: View {
    var body: some View {
        Text("KAMPANJ")
            .font(.system(size: 11, weight: .bold))
            .foregroundStyle(.white)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(Capsule().fill(Color(red: 0.55, green: 0.15, blue: 0.25)))
    }
}

struct DealCard: View {
    let image: String
    let displayName: String
    let title: String
    var fallbackColor: Color = Color(white: 0.13)
    var width: CGFloat = 240
    var height: CGFloat = 300
    var showTag: Bool = true

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ZStack(alignment: .topTrailing) {
                BrandImage(name: image, displayName: displayName, fallbackColor: fallbackColor)
                    .frame(width: width, height: height)
                    .clipShape(RoundedRectangle(cornerRadius: 16))

                if showTag {
                    KampanjTag()
                        .padding(12)
                }
            }
            Text(title)
                .foregroundStyle(.white)
                .font(.system(size: 18, weight: .bold))
                .frame(width: width, alignment: .center)
                .multilineTextAlignment(.center)
                .padding(.bottom, 4)
        }
        .frame(width: width)
    }
}

struct GridDealCard: View {
    let image: String
    let displayName: String
    let title: String
    var fallbackColor: Color = Color(white: 0.13)
    var showTag: Bool = true

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .topTrailing) {
                BrandImage(name: image, displayName: displayName, fallbackColor: fallbackColor)
                    .aspectRatio(0.78, contentMode: .fill)
                    .frame(maxWidth: .infinity)
                    .clipShape(RoundedRectangle(cornerRadius: 14))

                if showTag {
                    KampanjTag()
                        .padding(10)
                }
            }
            Text(title)
                .foregroundStyle(.white)
                .font(.system(size: 15, weight: .bold))
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                .padding(.bottom, 6)
                .padding(.horizontal, 4)
        }
    }
}
