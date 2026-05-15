//
//  CalenderView.swift
//  stuk
//
//  Created by Axel Langenskiöld on 2024-09-12.
//

import SwiftUI

struct EventEntry {
    let image: String
    let displayName: String
    let nation: String
    let event: String
    let date: String
    let fallback: Color
}

struct CalenderView: View {
    @Binding var path: NavigationPath
    @State private var selectedTab = 0

    private let events: [EventEntry] = [
        .init(image: "lunch_blekingska", displayName: "LUNCH", nation: "Blekingska Nationen", event: "Lunch | Blekingska", date: "TORS 14 MAJ 12:00 - 13:30", fallback: Color(red: 0.65, green: 0.80, blue: 0.50)),
        .init(image: "sopplunch_vg", displayName: "SOPPLUNCH", nation: "Västgöta Nation", event: "Sopplunch", date: "TORS 14 MAJ 12:00 - 14:00", fallback: Color(red: 0.92, green: 0.92, blue: 0.88)),
        .init(image: "kryckans", displayName: "Kryckans Hörna", nation: "Malmö Nation", event: "Kryckans Hörna", date: "TORS 14 MAJ 18:00 - 23:00", fallback: Color(white: 0.18)),
        .init(image: "afternoontea", displayName: "Afternoon Tea", nation: "Helsingkrona Nation", event: "Afternoon Tea", date: "FRE 15 MAJ 14:00 - 16:00", fallback: Color(white: 0.18)),
        .init(image: "tapas", displayName: "Tapas", nation: "Västgöta Nation", event: "Tapas Torsdag", date: "TORS 21 MAJ 19:00 - 22:00", fallback: Color(white: 0.18)),
    ]

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 0) {
                topHeader
                tabPills
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 18) {
                        ForEach(0..<events.count, id: \.self) { i in
                            eventCard(events[i])
                                .padding(.horizontal, 16)
                        }
                        Spacer(minLength: 120)
                    }
                    .padding(.top, 14)
                }
            }

            VStack {
                Spacer()
                BottomTabBar(path: $path, current: .calendar)
            }
            .ignoresSafeArea(edges: .bottom)
        }
        .navigationBarBackButtonHidden(true)
    }

    private var topHeader: some View {
        ZStack {
            Text("Evenemang")
                .foregroundStyle(.white)
                .font(.system(size: 18, weight: .heavy))
            HStack {
                Button(action: {}) {
                    Image(systemName: "calendar")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.white)
                        .frame(width: 42, height: 42)
                        .background(Circle().fill(Color.white.opacity(0.1)))
                        .padding(.leading, 16)
                }
                Spacer()
                Button(action: {}) {
                    Image(systemName: "line.3.horizontal.decrease")
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

    private var tabPills: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                pill(text: "Evenemang", selected: selectedTab == 0) { selectedTab = 0 }
                pill(text: "Utforska", selected: selectedTab == 1) { selectedTab = 1 }
                pillIcon(text: "Filter", system: "slider.horizontal.3") { }
                pill(text: "Lund", selected: false) { }
            }
            .padding(.horizontal, 16)
        }
        .padding(.top, 8)
    }

    private func pill(text: String, selected: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(text)
                .font(.system(size: 15, weight: selected ? .heavy : .semibold))
                .foregroundStyle(selected ? .black : .white)
                .padding(.horizontal, 22)
                .padding(.vertical, 10)
                .background(
                    Capsule().fill(selected ? Color.white : Color.white.opacity(0.10))
                )
        }
    }

    private func pillIcon(text: String, system: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Text(text)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(.white)
                Image(systemName: system)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.white)
            }
            .padding(.horizontal, 22)
            .padding(.vertical, 10)
            .background(Capsule().fill(Color.white.opacity(0.10)))
        }
    }

    private func eventCard(_ e: EventEntry) -> some View {
        VStack(spacing: 0) {
            BrandImage(name: e.image, displayName: e.displayName,
                       fallbackColor: e.fallback)
                .frame(height: 220)
                .clipped()
                .clipShape(RoundedCorner(radius: 12, corners: [.topLeft, .topRight]))

            VStack(alignment: .leading, spacing: 4) {
                Text(e.nation)
                    .foregroundStyle(.white.opacity(0.75))
                    .font(.system(size: 14))
                Text(e.event)
                    .foregroundStyle(.white)
                    .font(.system(size: 18, weight: .heavy))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            .background(Color(white: 0.06))

            Rectangle().fill(Color.white.opacity(0.12)).frame(height: 0.5)

            HStack(spacing: 10) {
                Image(systemName: "calendar")
                    .foregroundStyle(.white.opacity(0.7))
                Text(e.date)
                    .foregroundStyle(.white)
                    .font(.system(size: 14, weight: .semibold))
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            .background(Color(white: 0.06))
        }
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    CalenderView(path: .constant(NavigationPath()))
}
