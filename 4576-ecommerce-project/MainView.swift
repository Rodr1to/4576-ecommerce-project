import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = ShopViewModel()
    
    var body: some View {
        TabView {
            // Inicio
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            // Favoritos
            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "heart.fill")
                }
            
            // Carrito
            CartView()
                .tabItem {
                    Label("Cart", systemImage: "cart.fill")
                }
        }
        .environmentObject(viewModel)
    }
}

#Preview {
    MainView()
}
