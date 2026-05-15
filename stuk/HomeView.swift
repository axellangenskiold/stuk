import SwiftUI
import SwiftData

struct HomeView: View {
    @State var path = NavigationPath()
    @State private var showSideMenu = false
    @State private var heroPage = 0

    var body: some View {
        NavigationStack(path: $path) {
            ZStack(alignment: .leading) {
                Color.black.ignoresSafeArea()

                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 0) {
                        heroSection
                        searchBar
                            .padding(.top, 18)
                            .padding(.horizontal, 16)

                        sectionHeader(title: "Hot deals", emoji: "🔥") {
                            path.append(Destination.hotDealsList)
                        }
                        .padding(.top, 22)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 14) {
                                Button { path.append(Destination.dealDetail) } label: {
                                    DealCard(image: "samsung", displayName: "SAMSUNG", title: "50% studentrabatt", fallbackColor: Color(red: 0.05, green: 0.18, blue: 0.05))
                                }
                                .buttonStyle(.plain)
                                DealCard(image: "viaplay", displayName: "viaplay", title: "Viaplay Total - 50% studentrabatt i 3 månader", fallbackColor: Color(red: 0.32, green: 0.05, blue: 0.10))
                                DealCard(image: "storytel", displayName: "storytel", title: "Prova gratis 45 dagar + 50% studentrabatt", fallbackColor: Color(red: 0.20, green: 0.35, blue: 0.40))
                            }
                            .padding(.horizontal, 16)
                        }
                        .padding(.top, 8)

                        sectionHeader(title: "Populära rabatter", emoji: "🛍") { }
                            .padding(.top, 26)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 14) {
                                DealCard(image: "hallon", displayName: "hallon", title: "Från 19 kr/mån i 5 månader", fallbackColor: Color(red: 0.80, green: 0.50, blue: 0.65))
                                DealCard(image: "iciw", displayName: "ICIW", title: "20% studentrabatt", fallbackColor: Color(red: 0.55, green: 0.40, blue: 0.40))
                                DealCard(image: "lindex", displayName: "LINDEX", title: "25% rabatt", fallbackColor: Color(red: 0.55, green: 0.70, blue: 0.85))
                            }
                            .padding(.horizontal, 16)
                        }
                        .padding(.top, 8)

                        sectionHeaderWithBadge(title: "Nya studentrabatter") { }
                            .padding(.top, 26)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 14) {
                                DealCard(image: "apple", displayName: "Apple", title: "10% studentrabatt", fallbackColor: Color(white: 0.10), showTag: false)
                                DealCard(image: "hm", displayName: "H&M", title: "15% studentrabatt", fallbackColor: Color(white: 0.10), showTag: false)
                                DealCard(image: "rituals", displayName: "Rituals", title: "20% studentrabatt", fallbackColor: Color(white: 0.10), showTag: false)
                            }
                            .padding(.horizontal, 16)
                        }
                        .padding(.top, 8)

                        Spacer(minLength: 120)
                    }
                }

                topBar

                // Bottom bar overlay
                VStack {
                    Spacer()
                    BottomTabBar(path: $path, current: .home)
                }
                .ignoresSafeArea(edges: .bottom)

                // Side menu overlay
                if showSideMenu {
                    Color.black.opacity(0.35)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation(.easeOut(duration: 0.25)) { showSideMenu = false }
                        }
                    SideMenuView(isOpen: $showSideMenu)
                        .transition(.move(edge: .leading))
                        .zIndex(2)
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationDestination(for: Destination.self) { destination in
                switch destination {
                case .calenderView: CalenderView(path: $path)
                case .ticketView:   TicketView(path: $path)
                case .cardView:     CardView(path: $path)
                case .profileView:  ProfileView(path: $path)
                case .homeView:     HomeView()
                case .setNameView:  SetNameView()
                case .hotDealsList: HotDealsListView(path: $path)
                case .dealDetail:   DealDetailView(path: $path)
                case .nearbyView:   NearbyView(path: $path)
                }
            }
        }
    }

    // MARK: - Hero

    private var heroSection: some View {
        ZStack(alignment: .bottom) {
            BrandImage(name: "hallon_hero", displayName: "hallon",
                       fallbackColor: Color(red: 0.65, green: 0.55, blue: 0.50))
                .frame(height: 620)
                .clipped()
                .overlay(
                    LinearGradient(colors: [.clear, .black.opacity(0.55), .black],
                                   startPoint: .center, endPoint: .bottom)
                )

            VStack(spacing: 14) {
                HStack(spacing: 8) {
                    Image(systemName: "leaf.fill")
                        .foregroundStyle(.white)
                    Text("hallon")
                        .font(.system(size: 44, weight: .heavy))
                        .foregroundStyle(.white)
                }
                .padding(.bottom, 4)

                Text("Från 19 kr/mån i 5 månader -\ninklusive 50 GB välkomstsurf!")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)

                Button(action: { path.append(Destination.dealDetail) }) {
                    Text("Till erbjudandet")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundStyle(Color(red: 0.30, green: 0.05, blue: 0.15))
                        .padding(.horizontal, 36)
                        .padding(.vertical, 14)
                        .background(
                            Capsule().fill(Color(red: 0.95, green: 0.70, blue: 0.85))
                        )
                }

                HStack(spacing: 6) {
                    Circle().fill(Color.white).frame(width: 7, height: 7)
                    Circle().fill(Color.white.opacity(0.4)).frame(width: 7, height: 7)
                }
                .padding(.top, 6)
            }
            .padding(.bottom, 30)
        }
        .frame(height: 620)
    }

    // MARK: - Search bar

    private var searchBar: some View {
        HStack {
            Text("Vad letar du efter?")
                .foregroundStyle(Color.white.opacity(0.55))
                .font(.system(size: 16))
            Spacer()
            Image(systemName: "magnifyingglass")
                .foregroundStyle(Color.white.opacity(0.7))
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 14)
        .background(
            Capsule().fill(Color.white.opacity(0.12))
        )
    }

    // MARK: - Top bar

    private var topBar: some View {
        VStack {
            HStack {
                Button(action: {
                    withAnimation(.easeOut(duration: 0.25)) { showSideMenu = true }
                }) {
                    Image(systemName: "line.3.horizontal")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(.white)
                        .frame(width: 42, height: 42)
                        .background(Circle().fill(Color.black.opacity(0.45)))
                }

                Spacer()

                Button(action: { path.append(Destination.nearbyView) }) {
                    Image(systemName: "mappin.and.ellipse")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.white)
                        .frame(width: 42, height: 42)
                        .background(Circle().fill(Color.black.opacity(0.45)))
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 8)
            Spacer()
        }
    }

    // MARK: - Section headers

    private func sectionHeader(title: String, emoji: String, action: @escaping () -> Void) -> some View {
        HStack {
            HStack(spacing: 6) {
                Text(title)
                    .foregroundStyle(.white)
                    .font(.system(size: 22, weight: .heavy))
                Text(emoji)
                    .font(.system(size: 22))
            }
            Spacer()
            Button(action: action) {
                Text("Visa alla")
                    .underline()
                    .foregroundStyle(.white)
                    .font(.system(size: 15))
            }
        }
        .padding(.horizontal, 16)
    }

    private func sectionHeaderWithBadge(title: String, action: @escaping () -> Void) -> some View {
        HStack {
            HStack(spacing: 8) {
                Text(title)
                    .foregroundStyle(.white)
                    .font(.system(size: 22, weight: .heavy))
                Text("NEW")
                    .font(.system(size: 10, weight: .heavy))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 3)
                    .background(RoundedRectangle(cornerRadius: 4).fill(Color(red: 0.30, green: 0.50, blue: 0.85)))
            }
            Spacer()
            Button(action: action) {
                Text("Visa alla")
                    .underline()
                    .foregroundStyle(.white)
                    .font(.system(size: 15))
            }
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    HomeView()
}
