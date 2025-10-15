//
//  MainView.swift
//  4576-ecommerce-project
//
//  Created by Rodrigo Valverde on 10/14/2025.
//

import SwiftUI

struct MainView: View {
    // We use @StateObject here to create the single instance of our ViewModel.
    // This instance will live as long as MainView exists.
    @StateObject private var viewModel = ShopViewModel()
    
    var body: some View {
        TabView {
            // Home Tab
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            // Favorites Tab
            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "heart.fill")
                }
            
            // Cart Tab
            CartView()
                .tabItem {
                    Label("Cart", systemImage: "cart.fill")
                }
        }
        // We use .environmentObject to make our viewModel
        // available to ALL views inside the TabView.
        // This is the modern way of sharing data.
        .environmentObject(viewModel)
    }
}

#Preview {
    MainView()
}
