//
//  BottomTabBar.swift
//  stuk
//

import SwiftUI

enum TabItem {
    case home, calendar, card, tickets, profile
}

struct BottomTabBar: View {
    @Binding var path: NavigationPath
    var current: TabItem
    var ticketBadge: Int = 1

    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.black)
                .frame(height: 90)
                .overlay(
                    Rectangle()
                        .fill(Color.white.opacity(0.08))
                        .frame(height: 0.5),
                    alignment: .top
                )

            HStack {
                tab(.home, system: "house.fill")
                tab(.calendar, system: "calendar")
                tab(.card, system: "rectangle.stack.fill")
                tab(.tickets, system: "ticket.fill", badge: ticketBadge)
                tab(.profile, system: "person.crop.circle.fill")
            }
            .padding(.horizontal, 14)
            .padding(.bottom, 24)
        }
        .frame(maxWidth: .infinity)
    }

    @ViewBuilder
    private func tab(_ item: TabItem, system: String, badge: Int = 0) -> some View {
        let isActive = current == item

        Button(action: { navigate(to: item) }) {
            ZStack(alignment: .topTrailing) {
                Image(systemName: system)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 26, height: 26)
                    .foregroundStyle(isActive ? .white : Color.white.opacity(0.55))
                    .padding(10)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(isActive ? Color.white.opacity(0.08) : Color.clear)
                    )

                if item == .tickets && badge > 0 {
                    Text("\(badge)")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 5)
                        .padding(.vertical, 2)
                        .background(Circle().fill(Color.red))
                        .offset(x: 4, y: -4)
                }
            }
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(.plain)
    }

    private func navigate(to item: TabItem) {
        if item == current { return }
        var transaction = Transaction()
        transaction.disablesAnimations = true
        withTransaction(transaction) {
            switch item {
            case .home:
                // pop to root
                while !path.isEmpty { path.removeLast() }
            case .calendar:
                resetAndAppend(.calenderView)
            case .card:
                resetAndAppend(.cardView)
            case .tickets:
                resetAndAppend(.ticketView)
            case .profile:
                resetAndAppend(.profileView)
            }
        }
    }

    private func resetAndAppend(_ destination: Destination) {
        while !path.isEmpty { path.removeLast() }
        path.append(destination)
    }
}
