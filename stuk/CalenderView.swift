//
//  CalenderView.swift
//  stuk
//
//  Created by Axel Langenskiöld on 2024-09-12.
//

import SwiftUI

struct CalenderView: View {
    @Binding var path: NavigationPath
    @State private var selectedTab = 0
    @State private var showCalendarModal = false
    @State private var showSortModal = false
    @State private var sortBy: SortChoice = .evenemang

    enum SortChoice { case evenemang, biljett }

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 0) {
                topHeader
                tabPills
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 18) {
                        ForEach(EventStore.events) { e in
                            Button(action: { path.append(Destination.eventDetail(e)) }) {
                                eventCard(e)
                            }
                            .buttonStyle(.plain)
                            .padding(.horizontal, 16)
                        }
                        Spacer(minLength: 140)
                    }
                    .padding(.top, 14)
                }
            }

            VStack {
                Spacer()
                BottomTabBar(path: $path, current: .calendar)
            }
            .ignoresSafeArea(edges: .bottom)

            if showCalendarModal {
                Color.black.opacity(0.45)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(.easeOut(duration: 0.2)) { showCalendarModal = false }
                    }
                CalendarModalView(onClose: {
                    withAnimation(.easeOut(duration: 0.2)) { showCalendarModal = false }
                })
                .transition(.move(edge: .bottom))
                .zIndex(2)
            }

            if showSortModal {
                Color.black.opacity(0.45)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(.easeOut(duration: 0.2)) { showSortModal = false }
                    }
                SortModalView(choice: $sortBy, onClose: {
                    withAnimation(.easeOut(duration: 0.2)) { showSortModal = false }
                })
                .transition(.move(edge: .bottom))
                .zIndex(2)
            }
        }
        .navigationBarBackButtonHidden(true)
    }

    private var topHeader: some View {
        ZStack {
            Text("Evenemang")
                .foregroundStyle(.white)
                .font(.system(size: 18, weight: .heavy))
            HStack {
                Button(action: {
                    withAnimation(.spring(response: 0.35, dampingFraction: 0.85)) {
                        showCalendarModal = true
                    }
                }) {
                    Image(systemName: "calendar")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.white)
                        .frame(width: 42, height: 42)
                        .background(Circle().fill(Color.white.opacity(0.1)))
                        .padding(.leading, 16)
                }
                Spacer()
                Button(action: {
                    withAnimation(.spring(response: 0.35, dampingFraction: 0.85)) {
                        showSortModal = true
                    }
                }) {
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
                pillIcon(text: "Filter", system: "slider.horizontal.3") {
                    withAnimation { showSortModal = true }
                }
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

    private func eventCard(_ e: EventItem) -> some View {
        VStack(spacing: 0) {
            ZStack(alignment: .bottom) {
                BrandImage(url: e.imageURL, displayName: e.title,
                           fallbackColor: e.accentColor)
                    .frame(height: 220)
                    .clipped()
                    .clipShape(RoundedCorner(radius: 12, corners: [.topLeft, .topRight]))
                Text(e.title)
                    .foregroundStyle(.white)
                    .font(.system(size: 18, weight: .heavy))
                    .shadow(radius: 2)
                    .padding(.bottom, 10)
            }
            VStack(alignment: .leading, spacing: 4) {
                Text(e.nation)
                    .foregroundStyle(.white.opacity(0.75))
                    .font(.system(size: 14))
                Text(e.title)
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

// MARK: Calendar modal

struct CalendarModalView: View {
    let onClose: () -> Void
    @State private var selected: Int? = 16

    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 18) {
                HStack {
                    Spacer()
                    Text("Kalender")
                        .foregroundStyle(.white)
                        .font(.system(size: 18, weight: .heavy))
                    Spacer()
                    Button("Rensa", action: { selected = nil })
                        .foregroundStyle(.blue)
                        .font(.system(size: 16, weight: .semibold))
                        .padding(.trailing, 16)
                }
                .padding(.top, 18)

                Text("Maj 2026")
                    .foregroundStyle(.white)
                    .font(.system(size: 16, weight: .semibold))

                let cols = Array(repeating: GridItem(.flexible(), spacing: 12), count: 7)
                LazyVGrid(columns: cols, spacing: 14) {
                    ForEach(27...31, id: \.self) { d in
                        dayCell(d, dim: true)
                    }
                    ForEach(1...31, id: \.self) { d in
                        dayCell(d, dim: false)
                    }
                    ForEach(1...7, id: \.self) { d in
                        dayCell(d, dim: true)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 30)
            }
            .background(Color.black)
        }
        .ignoresSafeArea()
    }

    @ViewBuilder
    private func dayCell(_ day: Int, dim: Bool) -> some View {
        VStack(spacing: 2) {
            Text("\(day)")
                .foregroundStyle(selected == day ? .white : (dim ? .white.opacity(0.35) : .white))
                .font(.system(size: 16, weight: selected == day ? .heavy : .regular))
            Circle()
                .fill(dim ? Color.clear : Color.blue)
                .frame(width: 5, height: 5)
        }
        .frame(maxWidth: .infinity, minHeight: 36)
        .onTapGesture { if !dim { selected = day } }
    }
}

// MARK: Sort modal

struct SortModalView: View {
    @Binding var choice: CalenderView.SortChoice
    let onClose: () -> Void

    var body: some View {
        VStack {
            Spacer()
            VStack(alignment: .leading, spacing: 0) {
                Text("Sortera")
                    .foregroundStyle(.white)
                    .font(.system(size: 18, weight: .heavy))
                    .frame(maxWidth: .infinity)
                    .padding(.top, 24)
                    .padding(.bottom, 18)

                radioRow("Evenemang", selected: choice == .evenemang) { choice = .evenemang }
                Rectangle().fill(Color.white.opacity(0.1)).frame(height: 0.5)
                radioRow("Biljettsläpp", selected: choice == .biljett) { choice = .biljett }

                Button(action: onClose) {
                    Text("Visa resultat")
                        .font(.system(size: 17, weight: .heavy))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Capsule().fill(Color.blue))
                        .padding(.horizontal, 16)
                }
                .padding(.top, 24)
                .padding(.bottom, 30)
            }
            .background(Color.black)
        }
        .ignoresSafeArea()
    }

    private func radioRow(_ text: String, selected: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack {
                Text(text)
                    .foregroundStyle(.white)
                    .font(.system(size: 17))
                Spacer()
                ZStack {
                    Circle()
                        .stroke(Color.white.opacity(0.5), lineWidth: 1.5)
                        .frame(width: 22, height: 22)
                    if selected {
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 13, height: 13)
                    }
                }
            }
            .padding(.horizontal, 18)
            .padding(.vertical, 14)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    CalenderView(path: .constant(NavigationPath()))
}
