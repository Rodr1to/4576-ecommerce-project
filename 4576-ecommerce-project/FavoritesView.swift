//
//  FavoritesView.swift
//  4576-ecommerce-project
//
//  Created by Rodrigo Valverde on 10/14/2025.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var viewModel: ShopViewModel
    
    // We create a computed property that filters only the favorite products.
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
