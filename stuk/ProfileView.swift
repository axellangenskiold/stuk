//
//  ProfileView.swift
//  stuk
//
//  Created by Axel Langenskiöld on 2024-09-12.
//

import SwiftUI

struct ProfileView: View {
    @Binding var path: NavigationPath

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 0) {
                headerBar
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {
                        userCard
                        accountGroup
                        infoGroup
                        logoutButton
                        Spacer(minLength: 120)
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 14)
                }
            }

            VStack {
                Spacer()
                BottomTabBar(path: $path, current: .profile)
            }
            .ignoresSafeArea(edges: .bottom)
        }
        .navigationBarBackButtonHidden(true)
    }

    private var headerBar: some View {
        ZStack {
            Text("Profil")
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

    private var userCard: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 4) {
                Text(Shared.shared.name)
                    .font(.system(size: 22, weight: .heavy))
                    .foregroundStyle(.white)
                Text(Shared.shared.email)
                    .font(.system(size: 14))
                    .foregroundStyle(.white.opacity(0.5))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 18)
            .padding(.vertical, 18)

            divider
            row(icon: "rectangle.and.pencil.and.ellipsis", title: "Redigera profil") { }
            divider
            row(icon: "ticket", title: "Mina biljetter") { }
            divider
            row(icon: "heart", title: "Mina rabatter") { }
        }
        .background(RoundedRectangle(cornerRadius: 14).fill(Color(white: 0.08)))
    }

    private var accountGroup: some View {
        VStack(spacing: 0) {
            row(icon: "gearshape", title: "Inställningar") {
                path.append(Destination.setNameView)
            }
            divider
            rowExternal(icon: "doc.text", title: "Allmänna villkor") { }
            divider
            rowExternal(icon: "circle.dashed", title: "Integritetspolicy") { }
            divider
            row(icon: "envelope", title: "Medlemsservice") { }
        }
        .background(RoundedRectangle(cornerRadius: 14).fill(Color(white: 0.08)))
    }

    private var infoGroup: some View {
        EmptyView()
    }

    private var logoutButton: some View {
        Button(action: {}) {
            Text("Logga ut")
                .font(.system(size: 17, weight: .heavy))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(RoundedRectangle(cornerRadius: 14).fill(Color(white: 0.12)))
        }
    }

    private var divider: some View {
        Rectangle().fill(Color.white.opacity(0.08)).frame(height: 0.5)
    }

    private func row(icon: String, title: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack(spacing: 14) {
                Image(systemName: icon)
                    .font(.system(size: 20, weight: .regular))
                    .frame(width: 26, height: 26)
                    .foregroundStyle(.white)
                Text(title)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundStyle(.white)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundStyle(.white.opacity(0.6))
                    .font(.system(size: 14, weight: .semibold))
            }
            .padding(.horizontal, 18)
            .padding(.vertical, 18)
        }
        .buttonStyle(.plain)
    }

    private func rowExternal(icon: String, title: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack(spacing: 14) {
                Image(systemName: icon)
                    .font(.system(size: 20, weight: .regular))
                    .frame(width: 26, height: 26)
                    .foregroundStyle(.white)
                Text(title)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundStyle(.white)
                Spacer()
                Image(systemName: "arrow.up.right.square")
                    .foregroundStyle(.white.opacity(0.6))
                    .font(.system(size: 16, weight: .semibold))
            }
            .padding(.horizontal, 18)
            .padding(.vertical, 18)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    ProfileView(path: .constant(NavigationPath()))
}
