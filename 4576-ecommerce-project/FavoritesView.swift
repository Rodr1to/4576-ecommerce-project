//
//  FavoritesView.swift
//  4576-ecommerce-project
//
import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var viewModel: ShopViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.favoriteProducts.isEmpty {
                    Spacer()
                    Text("You have no favorite items yet.")
                        .foregroundColor(.secondary)
                    Spacer()
                } else {
                    List(viewModel.favoriteProducts) { product in
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
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Favorites")
        }
    }
}

#Preview {
    MainView()
}
