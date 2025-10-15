import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var viewModel: ShopViewModel
    
    var favoriteProducts: [Product] {
        viewModel.products.filter { $0.isFavorite }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if favoriteProducts.isEmpty {
                    Spacer()
                    Text("You have no favorite items yet.")
                        .foregroundColor(.secondary)
                    Spacer()
                } else {
                    List(favoriteProducts) { product in
                        HStack {
                            Image(product.image)
                                .resizable()
                                .frame(width: 60, height: 60)
                                .cornerRadius(8)
                            VStack(alignment: .leading) {
                                Text(product.name).font(.headline)
                                Text("$\(product.price, specifier: "%.2f")").font(.subheadline)
                            }
                            Spacer()
                        }
                    }
                }
            }
            .navigationTitle("Favorites")
        }
    }
}

#Preview {
    MainView()
}
