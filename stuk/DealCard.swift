//
//  DealCard.swift
//  stuk
//

import SwiftUI

/// Renders a brand image. Priority: remote URL → local asset → colored fallback with brand text.
struct BrandImage: View {
    var url: String? = nil
    var localName: String? = nil
    var displayName: String? = nil
    var fallbackColor: Color = Color(white: 0.13)
    var fontSize: CGFloat = 26

    // Convenience initializers
    init(name: String, displayName: String? = nil,
         fallbackColor: Color = Color(white: 0.13), fontSize: CGFloat = 26) {
        self.url = nil
        self.localName = name
        self.displayName = displayName
        self.fallbackColor = fallbackColor
        self.fontSize = fontSize
    }

    init(url: String?, displayName: String? = nil,
         fallbackColor: Color = Color(white: 0.13), fontSize: CGFloat = 26) {
        self.url = url
        self.localName = nil
        self.displayName = displayName
        self.fallbackColor = fallbackColor
        self.fontSize = fontSize
    }

    var body: some View {
        Group {
            if let urlString = url, let nsurl = URL(string: urlString) {
                AsyncImage(url: nsurl) { phase in
                    switch phase {
                    case .success(let img):
                        img.resizable().scaledToFill()
                    case .empty:
                        loadingPlaceholder
                    case .failure:
                        placeholderView
                    @unknown default:
                        placeholderView
                    }
                }
            } else if let local = localName, UIImage(named: local) != nil {
                Image(local).resizable().scaledToFill()
            } else {
                placeholderView
            }
        }
    }

    private var loadingPlaceholder: some View {
        ZStack {
            fallbackColor
            ProgressView()
                .tint(.white.opacity(0.6))
        }
    }

    private var placeholderView: some View {
        ZStack {
            fallbackColor
            if let dn = displayName {
                Text(dn.uppercased())
                    .font(.system(size: fontSize, weight: .heavy))
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
    let item: DealItem
    var width: CGFloat = 240
    var height: CGFloat = 300

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ZStack(alignment: .topTrailing) {
                ZStack(alignment: .bottom) {
                    BrandImage(url: item.imageURL, displayName: nil,
                               fallbackColor: item.accentColor)
                        .frame(width: width, height: height)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    Text(item.brand.uppercased())
                        .font(.system(size: 22, weight: .heavy))
                        .foregroundStyle(.white)
                        .shadow(radius: 2)
                        .padding(.bottom, 18)
                }
                if item.isCampaign {
                    KampanjTag().padding(12)
                }
            }
            Text(item.title)
                .foregroundStyle(.white)
                .font(.system(size: 17, weight: .bold))
                .frame(width: width, alignment: .center)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .padding(.bottom, 4)
        }
        .frame(width: width)
    }
}

struct GridDealCard: View {
    let item: DealItem

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .topTrailing) {
                ZStack(alignment: .bottom) {
                    BrandImage(url: item.imageURL, displayName: nil,
                               fallbackColor: item.accentColor)
                        .aspectRatio(0.78, contentMode: .fill)
                        .frame(maxWidth: .infinity)
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                    Text(item.brand.uppercased())
                        .font(.system(size: 18, weight: .heavy))
                        .foregroundStyle(.white)
                        .shadow(radius: 2)
                        .padding(.bottom, 14)
                }
                if item.isCampaign {
                    KampanjTag().padding(10)
                }
            }
            Text(item.title)
                .foregroundStyle(.white)
                .font(.system(size: 15, weight: .bold))
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                .padding(.bottom, 6)
                .padding(.horizontal, 4)
        }
    }
}
