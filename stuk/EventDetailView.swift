//
//  EventDetailView.swift
//  stuk
//

import SwiftUI

struct EventDetailView: View {
    @Binding var path: NavigationPath
    let event: EventItem
    @State private var selectedDate = 0

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    BrandImage(url: event.imageURL, displayName: event.title,
                               fallbackColor: event.accentColor)
                        .frame(height: 380)
                        .clipped()
                        .overlay(alignment: .center) {
                            Text(event.title.uppercased())
                                .foregroundStyle(.white)
                                .font(.system(size: 36, weight: .heavy))
                                .shadow(radius: 3)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 24)
                        }

                    titleSection
                    detailsSection
                    dateSelector
                    divider
                    descriptionSection
                    Spacer(minLength: 140)
                }
            }

            topButtons

            VStack {
                Spacer()
                BottomTabBar(path: $path, current: .calendar)
            }
            .ignoresSafeArea(edges: .bottom)
        }
        .navigationBarBackButtonHidden(true)
    }

    private var titleSection: some View {
        Text(event.title)
            .foregroundStyle(.white)
            .font(.system(size: 26, weight: .heavy))
            .padding(.horizontal, 16)
            .padding(.top, 18)
    }

    private var detailsSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(spacing: 12) {
                Image(systemName: "calendar")
                    .foregroundStyle(.white.opacity(0.7))
                Text(event.date)
                    .foregroundStyle(.white)
                    .font(.system(size: 15, weight: .semibold))
            }
            HStack(alignment: .top, spacing: 12) {
                Image(systemName: "mappin.circle")
                    .foregroundStyle(.white.opacity(0.7))
                VStack(alignment: .leading, spacing: 2) {
                    Text(event.nation)
                        .foregroundStyle(.white)
                        .font(.system(size: 16, weight: .semibold))
                    Text(event.nationAddress)
                        .foregroundStyle(.white.opacity(0.7))
                        .font(.system(size: 14))
                }
            }
            HStack(spacing: 12) {
                Image(systemName: "person")
                    .foregroundStyle(.white.opacity(0.7))
                Text(event.nation)
                    .foregroundStyle(.white)
                    .font(.system(size: 15, weight: .semibold))
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 14)
    }

    private var dateSelector: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(0..<event.upcomingDates.count, id: \.self) { i in
                    let d = event.upcomingDates[i]
                    let isSel = i == selectedDate
                    Button(action: { selectedDate = i }) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(d.day)
                                .foregroundStyle(isSel ? Color(red: 0.50, green: 0.65, blue: 0.95) : .white)
                                .font(.system(size: 15, weight: .heavy))
                            Text(d.time)
                                .foregroundStyle(isSel ? .white : .white.opacity(0.8))
                                .font(.system(size: 14))
                        }
                        .padding(.horizontal, 18)
                        .padding(.vertical, 12)
                        .frame(width: 130, alignment: .leading)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(white: isSel ? 0.16 : 0.10))
                        )
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 16)
        }
        .padding(.top, 22)
    }

    private var divider: some View {
        Rectangle()
            .fill(Color.white.opacity(0.15))
            .frame(height: 0.5)
            .padding(.horizontal, 16)
            .padding(.top, 24)
    }

    private var descriptionSection: some View {
        Text(event.description)
            .foregroundStyle(.white)
            .font(.system(size: 15))
            .lineSpacing(4)
            .padding(.horizontal, 16)
            .padding(.top, 22)
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
    EventDetailView(path: .constant(NavigationPath()), event: EventStore.events[0])
}
