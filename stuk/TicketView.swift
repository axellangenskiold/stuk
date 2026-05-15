//
//  TicketView.swift
//  stuk
//
//  Created by Axel Langenskiöld on 2024-09-12.
//

import SwiftUI

struct CouponEntry: Identifiable {
    let id = UUID()
    let image: String
    let displayName: String
    let brand: String
    let title: String
    let validUntil: String
    let bgColor: Color
    let textOnTop: Color
}

/// Scalloped/serrated edge shape used to separate the logo area from the text area on coupon cards.
struct ScallopEdge: Shape {
    var bumpCount: Int = 18
    var radius: CGFloat = 6

    func path(in rect: CGRect) -> Path {
        var p = Path()
        let step = rect.width / CGFloat(bumpCount)
        let y = rect.midY
        p.move(to: CGPoint(x: 0, y: 0))
        p.addLine(to: CGPoint(x: rect.width, y: 0))
        p.addLine(to: CGPoint(x: rect.width, y: y - radius))
        // bottom edge of top half with downward bumps
        for i in stride(from: bumpCount, to: 0, by: -1) {
            let x = step * CGFloat(i)
            p.addArc(center: CGPoint(x: x - step / 2, y: y),
                     radius: radius, startAngle: .degrees(0),
                     endAngle: .degrees(180), clockwise: true)
        }
        p.addLine(to: CGPoint(x: 0, y: 0))
        p.closeSubpath()
        return p
    }
}

struct CouponCard: View {
    let coupon: CouponEntry

    var body: some View {
        VStack(spacing: 0) {
            // Top half - logo area with scalloped bottom
            ZStack {
                coupon.bgColor
                BrandImage(name: coupon.image, displayName: coupon.displayName,
                           fallbackColor: coupon.bgColor)
                    .scaledToFit()
                    .padding(20)
            }
            .frame(height: 160)
            .mask(ScallopEdge().scale(x: 1, y: 2, anchor: .top))
            .frame(height: 160)

            // Bottom info
            VStack(alignment: .leading, spacing: 6) {
                Text(coupon.brand)
                    .font(.system(size: 13))
                    .foregroundStyle(.white.opacity(0.7))
                Text(coupon.title)
                    .font(.system(size: 16, weight: .heavy))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                Spacer(minLength: 4)
                Rectangle().fill(Color.white.opacity(0.1)).frame(height: 0.5)
                Text(coupon.validUntil)
                    .font(.system(size: 12))
                    .foregroundStyle(.white.opacity(0.5))
                    .padding(.top, 4)
            }
            .padding(12)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(white: 0.07))
        }
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }
}

struct TicketView: View {
    @Binding var path: NavigationPath
    @State private var selectedCoupon: CouponEntry? = nil

    private let coupons: [CouponEntry] = [
        .init(image: "viaplay_coupon", displayName: "viaplay", brand: "Viaplay Total",
              title: "50% studentrabatt i 3 mån", validUntil: "Giltig till 31 maj 2026",
              bgColor: Color(red: 0.10, green: 0.12, blue: 0.22), textOnTop: .white),
        .init(image: "steam_hotel", displayName: "STEAM\nHOTEL", brand: "The Steam Hotel",
              title: "25% studentrabatt", validUntil: "Giltig till 30 juni 2026",
              bgColor: Color(red: 0.32, green: 0.38, blue: 0.36), textOnTop: .white),
        .init(image: "storytel_coupon", displayName: "storytel", brand: "Storytel",
              title: "30 dagar gratis + 50% studentrabatt", validUntil: "Giltig till 30 juni 2026",
              bgColor: Color(white: 0.06), textOnTop: .white),
        .init(image: "sejfa_coupon", displayName: "sejfa", brand: "Sejfa",
              title: "40% studentrabatt i 12 månader", validUntil: "Giltig till 30 juni 2026",
              bgColor: Color(red: 0.62, green: 0.50, blue: 0.95), textOnTop: .white),
        .init(image: "tv4_coupon", displayName: "TV4", brand: "TV4 Play Plus",
              title: "1 månad gratis", validUntil: "Giltig till 30 juni 2026",
              bgColor: Color(red: 0.90, green: 0.10, blue: 0.10), textOnTop: .white),
        .init(image: "fitness24_coupon", displayName: "FITNESS\n24 SEVEN", brand: "Fitness24Seven",
              title: "15% studentrabatt i 3 månader", validUntil: "Giltig till 30 juni 2026",
              bgColor: Color(red: 0.10, green: 0.22, blue: 0.40), textOnTop: .white),
    ]

    private let cols = [GridItem(.flexible(), spacing: 14), GridItem(.flexible(), spacing: 14)]

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 0) {
                headerBar
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: cols, spacing: 18) {
                        ForEach(coupons) { c in
                            Button(action: {
                                withAnimation(.spring(response: 0.35, dampingFraction: 0.85)) {
                                    selectedCoupon = c
                                }
                            }) {
                                CouponCard(coupon: c)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 12)
                    .padding(.bottom, 140)
                }
            }

            VStack {
                Spacer()
                BottomTabBar(path: $path, current: .tickets)
            }
            .ignoresSafeArea(edges: .bottom)

            // Modal
            if let c = selectedCoupon {
                Color.black.opacity(0.55)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(.easeOut(duration: 0.2)) { selectedCoupon = nil }
                    }
                CouponDetailSheet(coupon: c) {
                    withAnimation(.easeOut(duration: 0.2)) { selectedCoupon = nil }
                }
                .transition(.move(edge: .bottom))
                .zIndex(2)
            }
        }
        .navigationBarBackButtonHidden(true)
    }

    private var headerBar: some View {
        ZStack {
            Text("Kuponger")
                .foregroundStyle(.white)
                .font(.system(size: 18, weight: .heavy))
            HStack {
                Button(action: {}) {
                    Image(systemName: "line.3.horizontal")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.white)
                        .frame(width: 42, height: 42)
                        .background(Circle().fill(Color.white.opacity(0.1)))
                        .padding(.leading, 16)
                }
                Spacer()
                Button(action: {}) {
                    Image(systemName: "magnifyingglass")
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
}

struct CouponDetailSheet: View {
    let coupon: CouponEntry
    let onClose: () -> Void

    var body: some View {
        VStack {
            Spacer()
            sheetContent
                .background(
                    Color(red: 0.10, green: 0.12, blue: 0.22)
                        .clipShape(RoundedCorner(radius: 24, corners: [.topLeft, .topRight]))
                )
        }
        .ignoresSafeArea()
    }

    private var sheetContent: some View {
        VStack(spacing: 18) {
            closeButtonRow
            brandLogo
            titleText
            descriptionText
            sheetDivider
            expiryText
            useCouponButton
        }
    }

    private var closeButtonRow: some View {
        HStack {
            Spacer()
            Button(action: onClose) {
                Image(systemName: "xmark")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(.white)
                    .frame(width: 36, height: 36)
                    .background(Circle().fill(Color.white.opacity(0.15)))
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 16)
    }

    private var brandLogo: some View {
        BrandImage(name: coupon.image,
                   displayName: coupon.displayName,
                   fallbackColor: Color.clear,
                   fontSize: 36)
            .scaledToFit()
            .frame(height: 80)
            .padding(.bottom, 4)
    }

    private var titleText: some View {
        Text(coupon.title)
            .foregroundStyle(.white)
            .font(.system(size: 22, weight: .heavy))
            .multilineTextAlignment(.center)
    }

    private var descriptionText: some View {
        Text("Nu får du Viaplay Total till halva priset i 3 månader så du kan se Hockey-VM, Formel 1 samt den rafflande avslutningen på Premier League och finalerna av Svenska Cupen och Champions League!\n\nSåklart även mängder av reality, serier och filmer!")
            .foregroundStyle(.white.opacity(0.85))
            .font(.system(size: 14))
            .multilineTextAlignment(.center)
            .padding(.horizontal, 24)
    }

    private var sheetDivider: some View {
        Rectangle()
            .fill(Color.white.opacity(0.15))
            .frame(height: 0.5)
            .padding(.horizontal, 24)
    }

    private var expiryText: some View {
        Text("Denna kupong löper ut 31 maj 2026. När den har aktiverats förblir den giltig i 4 timmar innan den försvinner.")
            .foregroundStyle(.white.opacity(0.75))
            .font(.system(size: 14))
            .multilineTextAlignment(.center)
            .padding(.horizontal, 24)
            .padding(.bottom, 6)
    }

    private var useCouponButton: some View {
        Button(action: {}) {
            Text("ANVÄND KUPONG")
                .font(.system(size: 17, weight: .heavy))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(Capsule().fill(Color(red: 0.05, green: 0.78, blue: 0.45)))
                .padding(.horizontal, 18)
        }
        .padding(.bottom, 30)
    }
}

#Preview {
    TicketView(path: .constant(NavigationPath()))
}
