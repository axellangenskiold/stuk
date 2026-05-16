//
//  DealDetailView.swift
//  stuk
//

import SwiftUI

struct DealDetailView: View {
    @Binding var path: NavigationPath
    let item: DealItem
    @State private var isFavorite = false

    private var similar: [DealItem] { DealStore.similar(to: item) }

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    heroImage
                    title
                    desc
                    ctaButton
                    benefitRow
                    brandHeader
                    if !similar.isEmpty { similarSection }
                    villkorSection
                    Spacer(minLength: 140)
                }
            }

            topButtons

            VStack {
                Spacer()
                BottomTabBar(path: $path, current: .home)
            }
            .ignoresSafeArea(edges: .bottom)
        }
        .navigationBarBackButtonHidden(true)
    }

    private var heroImage: some View {
        ZStack(alignment: .bottom) {
            BrandImage(url: item.imageURL, displayName: nil,
                       fallbackColor: item.accentColor)
                .frame(height: 420)
                .clipped()
            Text(item.brand.uppercased())
                .font(.system(size: 30, weight: .heavy))
                .foregroundStyle(.white)
                .shadow(radius: 3)
                .padding(.bottom, 24)
        }
    }

    private var title: some View {
        Text(item.title)
            .foregroundStyle(.white)
            .font(.system(size: 26, weight: .heavy))
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.top, 18)
            .padding(.horizontal, 24)
            .multilineTextAlignment(.center)
    }

    private var desc: some View {
        Text(item.description)
            .foregroundStyle(.white.opacity(0.85))
            .font(.system(size: 15))
            .multilineTextAlignment(.center)
            .padding(.horizontal, 24)
            .padding(.top, 18)
            .lineLimit(8)
    }

    private var ctaButton: some View {
        Button(action: {}) {
            Text("Till erbjudandet")
                .font(.system(size: 17, weight: .semibold))
                .foregroundStyle(.white)
                .padding(.horizontal, 60)
                .padding(.vertical, 14)
                .background(Capsule().fill(item.buttonColor))
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 24)
    }

    private var benefitRow: some View {
        VStack(spacing: 10) {
            row(icon: "checkmark.circle.fill", color: .green, text: "Fri frakt inom Sverige")
            row(icon: "checkmark.circle.fill", color: .green, text: "Fria returer")
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 14)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.white.opacity(0.25), lineWidth: 1)
        )
        .padding(.horizontal, 16)
        .padding(.top, 32)
    }

    private func row(icon: String, color: Color, text: String) -> some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundStyle(color)
                .font(.system(size: 20))
            Text(text)
                .foregroundStyle(.white)
                .font(.system(size: 15, weight: .semibold))
            Spacer()
        }
    }

    private var brandHeader: some View {
        Text("\(item.brand): \(item.title)")
            .foregroundStyle(.white)
            .font(.system(size: 22, weight: .heavy))
            .padding(.horizontal, 16)
            .padding(.top, 28)
    }

    private var similarSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Liknande rabatter")
                .foregroundStyle(.white)
                .font(.system(size: 20, weight: .heavy))
                .padding(.horizontal, 16)
                .padding(.top, 32)

            let cols = [GridItem(.flexible(), spacing: 14), GridItem(.flexible(), spacing: 14)]
            LazyVGrid(columns: cols, spacing: 18) {
                ForEach(similar.prefix(4)) { d in
                    Button(action: { path.append(Destination.dealDetail(d)) }) {
                        GridDealCard(item: d)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 10)
        }
    }

    private var villkorSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Villkor")
                .foregroundStyle(.white)
                .font(.system(size: 20, weight: .heavy))
            Text(item.terms)
                .foregroundStyle(.white.opacity(0.7))
                .font(.system(size: 14))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(18)
        .background(RoundedRectangle(cornerRadius: 12).fill(Color(white: 0.08)))
        .padding(.horizontal, 16)
        .padding(.top, 32)
    }

    private var topButtons: some View {
        VStack {
            HStack {
                Button(action: { path.removeLast() }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.white)
                        .frame(width: 42, height: 42)
                        .background(Circle().fill(Color.black.opacity(0.55)))
                }
                Spacer()
                Button(action: { isFavorite.toggle() }) {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.white)
                        .frame(width: 42, height: 42)
                        .background(Circle().fill(Color.black.opacity(0.55)))
                }
                Button(action: {}) {
                    Image(systemName: "square.and.arrow.up")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.white)
                        .frame(width: 42, height: 42)
                        .background(Circle().fill(Color.black.opacity(0.55)))
                }
            }
            .padding(.horizontal, 12)
            .padding(.top, 8)
            Spacer()
        }
    }
}

#Preview {
    DealDetailView(path: .constant(NavigationPath()), item: DealStore.hotDeals[0])
}
