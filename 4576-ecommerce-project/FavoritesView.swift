//
//  FavoritesView.swift
//  4576-ecommerce-project
//
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
                    List {
                        ForEach(favoriteProducts) { product in
                            HStack(spacing: 15) {
                                AsyncImage(url: URL(string: product.thumbnail)) { image in
                                    image
                                        .resizable()
                                        .frame(width: 60, height: 60)
                                        .cornerRadius(8)
                                } placeholder: {
                                    ProgressView()
                                        .frame(width: 60, height: 60)
                                }
                                
                                VStack(alignment: .leading) {
                                    Text(product.title).font(.headline)
                                    Text("$\(product.price, specifier: "%.2f")").font(.subheadline)
                                }
                                Spacer()
                            }
                        }
                        .onDelete(perform: removeFavorite)
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Favorites")
        }
    }
    

    private func removeFavorite(at offsets: IndexSet) {
        let productsToRemove = offsets.map { favoriteProducts[$0] }
        
        for product in productsToRemove {
            viewModel.toggleFavorite(for: product)
        }
    }
}

#Preview {
    MainView()
}
