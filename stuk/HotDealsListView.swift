//
//  HotDealsListView.swift
//  stuk
//

import SwiftUI

struct HotDealsListView: View {
    @Binding var path: NavigationPath
    let category: String?

    private var deals: [DealItem] {
        if let c = category {
            return DealStore.byCategory(c)
        }
        return DealStore.hotDeals + DealStore.popular + DealStore.newDeals
    }

    private let cols = [GridItem(.flexible(), spacing: 14), GridItem(.flexible(), spacing: 14)]

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 0) {
                headerBar
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: cols, spacing: 22) {
                        ForEach(deals) { d in
                            Button(action: { path.append(Destination.dealDetail(d)) }) {
                                GridDealCard(item: d)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 12)
                    .padding(.bottom, 120)
                }
            }

            VStack {
                Spacer()
                BottomTabBar(path: $path, current: .home)
            }
            .ignoresSafeArea(edges: .bottom)
        }
        .navigationBarBackButtonHidden(true)
    }

    private var headerBar: some View {
        ZStack {
            HStack(spacing: 6) {
                Text(category ?? "Hot deals")
                    .foregroundStyle(.white)
                    .font(.system(size: 22, weight: .heavy))
                if category == nil {
                    Text("🔥").font(.system(size: 22))
                }
            }
            HStack {
                Button(action: { path.removeLast() }) {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.white)
                        .font(.system(size: 20, weight: .semibold))
                        .padding(.leading, 16)
                }
                Spacer()
            }
        }
        .padding(.vertical, 14)
    }
}

#Preview {
    HotDealsListView(path: .constant(NavigationPath()), category: nil)
}
