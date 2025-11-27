import SwiftUI

struct MainView: View {
    @EnvironmentObject var viewModel: ShopViewModel
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "heart.fill")
                }
            
            CartView()
                .tabItem {
                    Label("Cart", systemImage: "cart.fill")
                }
        }
    }
}
