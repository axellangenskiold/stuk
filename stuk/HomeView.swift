import SwiftUI
import SwiftData

struct HomeView: View {
    @State var path = NavigationPath()
    @State private var showSideMenu = false

    private let heroDeals: [DealItem] = Array(DealStore.popular.prefix(2))

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

                        section(title: "Hot deals", emoji: "🔥",
                                deals: DealStore.hotDeals,
                                allRoute: .hotDealsList(category: nil))

                        section(title: "Populära rabatter", emoji: "🛍",
                                deals: DealStore.popular,
                                allRoute: .hotDealsList(category: nil))

                        sectionBadge(title: "Nya studentrabatter",
                                     deals: DealStore.newDeals,
                                     allRoute: .hotDealsList(category: nil))

                        section(title: "TV & Streaming", emoji: "📺",
                                deals: DealStore.tvStreaming,
                                allRoute: .hotDealsList(category: "TV & Streaming"))

                        section(title: "Mobil & Bredband", emoji: "",
                                deals: DealStore.mobile,
                                allRoute: .hotDealsList(category: "Mobil & Bredband"))

                        section(title: "Kläder & Mode", emoji: "",
                                deals: DealStore.fashion,
                                allRoute: .hotDealsList(category: "Kläder & Mode"))

                        section(title: "Hälsa & Apotek", emoji: "",
                                deals: DealStore.health,
                                allRoute: .hotDealsList(category: "Hälsa & Apotek"))

                        section(title: "Sport & Träning", emoji: "",
                                deals: DealStore.sport,
                                allRoute: .hotDealsList(category: "Sport & Träning"))

                        section(title: "Smycken & Accessoarer", emoji: "",
                                deals: DealStore.jewelry,
                                allRoute: .hotDealsList(category: "Smycken & Accessoarer"))

                        Spacer(minLength: 120)
                    }
                }

                topBar

                VStack {
                    Spacer()
                    BottomTabBar(path: $path, current: .home)
                }
                .ignoresSafeArea(edges: .bottom)

                if showSideMenu {
                    Color.black.opacity(0.35)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation(.easeOut(duration: 0.25)) { showSideMenu = false }
                        }
                    SideMenuView(isOpen: $showSideMenu) { category in
                        withAnimation(.easeOut(duration: 0.25)) { showSideMenu = false }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            path.append(Destination.hotDealsList(category: category))
                        }
                    }
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
                case .hotDealsList(let cat): HotDealsListView(path: $path, category: cat)
                case .dealDetail(let item):  DealDetailView(path: $path, item: item)
                case .eventDetail(let e):    EventDetailView(path: $path, event: e)
                case .nearbyView:   NearbyView(path: $path)
                case .nearbyCity(let city):  NearbyCityView(path: $path, city: city)
                }
            }
        }
    }

    // MARK: - Hero

    private var heroSection: some View {
        TabView {
            ForEach(heroDeals) { deal in
                heroCard(deal)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(height: 620)
        .overlay(alignment: .bottom) {
            HStack(spacing: 6) {
                ForEach(0..<heroDeals.count, id: \.self) { i in
                    Circle()
                        .fill(Color.white.opacity(i == 0 ? 1.0 : 0.4))
                        .frame(width: 7, height: 7)
                }
            }
            .padding(.bottom, 10)
        }
    }

    private func heroCard(_ deal: DealItem) -> some View {
        ZStack(alignment: .bottom) {
            BrandImage(url: deal.imageURL, displayName: deal.brand,
                       fallbackColor: deal.accentColor)
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
                    Text(deal.brand)
                        .font(.system(size: 44, weight: .heavy))
                        .foregroundStyle(.white)
                }
                .padding(.bottom, 4)

                Text(deal.title)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)

                Button(action: { path.append(Destination.dealDetail(deal)) }) {
                    Text("Till erbjudandet")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundStyle(Color(red: 0.30, green: 0.05, blue: 0.15))
                        .padding(.horizontal, 36)
                        .padding(.vertical, 14)
                        .background(
                            Capsule().fill(deal.buttonColor)
                        )
                }
            }
            .padding(.bottom, 50)
        }
        .frame(height: 620)
        .onTapGesture {
            path.append(Destination.dealDetail(deal))
        }
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
        .background(Capsule().fill(Color.white.opacity(0.12)))
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

    // MARK: - Sections

    private func section(title: String, emoji: String, deals: [DealItem],
                         allRoute: Destination) -> some View {
        VStack(spacing: 8) {
            HStack {
                HStack(spacing: 6) {
                    Text(title)
                        .foregroundStyle(.white)
                        .font(.system(size: 22, weight: .heavy))
                    if !emoji.isEmpty {
                        Text(emoji).font(.system(size: 22))
                    }
                }
                Spacer()
                Button(action: { path.append(allRoute) }) {
                    Text("Visa alla")
                        .underline()
                        .foregroundStyle(.white)
                        .font(.system(size: 15))
                }
            }
            .padding(.horizontal, 16)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 14) {
                    ForEach(deals) { deal in
                        Button(action: { path.append(Destination.dealDetail(deal)) }) {
                            DealCard(item: deal)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 16)
            }
        }
        .padding(.top, 26)
    }

    private func sectionBadge(title: String, deals: [DealItem],
                              allRoute: Destination) -> some View {
        VStack(spacing: 8) {
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
                        .background(
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color(red: 0.30, green: 0.50, blue: 0.85))
                        )
                }
                Spacer()
                Button(action: { path.append(allRoute) }) {
                    Text("Visa alla")
                        .underline()
                        .foregroundStyle(.white)
                        .font(.system(size: 15))
                }
            }
            .padding(.horizontal, 16)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 14) {
                    ForEach(deals) { deal in
                        Button(action: { path.append(Destination.dealDetail(deal)) }) {
                            DealCard(item: deal)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 16)
            }
        }
        .padding(.top, 26)
    }
}

#Preview {
    HomeView()
}
