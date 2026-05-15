//
//  DealDetailView.swift
//  stuk
//

import SwiftUI

struct DealDetailView: View {
    @Binding var path: NavigationPath
    @State private var isFavorite = false

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    Spacer(minLength: 40)

                    BrandImage(name: "samsung", displayName: "SAMSUNG",
                               fallbackColor: Color(red: 0.05, green: 0.18, blue: 0.05))
                        .frame(height: 380)
                        .clipped()

                    Text("50% studentrabatt")
                        .foregroundStyle(.white)
                        .font(.system(size: 26, weight: .heavy))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, 18)

                    Text("Ladda upp inför sommarens Fotbolls-VM med upp till 50% på utvalda TV-modeller hos Samsung - Gör dig redo för en spännande sommar med fotboll i världsklass!")
                        .foregroundStyle(.white.opacity(0.85))
                        .font(.system(size: 15))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24)
                        .padding(.top, 18)

                    Button(action: {}) {
                        Text("Till erbjudandet")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundStyle(.white)
                            .padding(.horizontal, 60)
                            .padding(.vertical, 14)
                            .background(Capsule().fill(Color(red: 0.92, green: 0.30, blue: 0.45)))
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top, 24)

                    HStack(spacing: 12) {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundStyle(.green)
                            .font(.system(size: 20))
                        Text("30 dagars öppet köp")
                            .foregroundStyle(.white)
                            .font(.system(size: 15, weight: .semibold))
                        Spacer()
                    }
                    .padding(.horizontal, 18)
                    .padding(.vertical, 16)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.white.opacity(0.25), lineWidth: 1)
                    )
                    .padding(.horizontal, 16)
                    .padding(.top, 32)

                    Text("Samsung")
                        .foregroundStyle(.white)
                        .font(.system(size: 22, weight: .heavy))
                        .padding(.horizontal, 16)
                        .padding(.top, 28)

                    Text("Njut av sommarens största sporthändelser med bild- och ljudkvalitet som tar dig närmare spelet. Just nu får du upp till 50% rabatt på utvalda TV- och soundbars från Samsung.")
                        .foregroundStyle(.white.opacity(0.7))
                        .font(.system(size: 15))
                        .padding(.horizontal, 16)
                        .padding(.top, 10)
                        .padding(.bottom, 140)
                }
            }

            // Top buttons
            VStack {
                HStack {
                    Button(action: { path.removeLast() }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundStyle(.white)
                            .padding(12)
                    }
                    Spacer()
                    Button(action: { isFavorite.toggle() }) {
                        Image(systemName: isFavorite ? "heart.fill" : "heart")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundStyle(.white)
                            .padding(12)
                    }
                    Button(action: {}) {
                        Image(systemName: "square.and.arrow.up")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundStyle(.white)
                            .padding(12)
                    }
                }
                .padding(.horizontal, 8)
                .padding(.top, 8)
                Spacer()
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
    DealDetailView(path: .constant(NavigationPath()))
}
