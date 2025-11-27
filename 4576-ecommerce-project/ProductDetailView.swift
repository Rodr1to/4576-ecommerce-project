//
//  ProductDetailView.swift
//  4576-ecommerce-project
//
import SwiftUI
import SwiftData

struct ProductDetailView: View {
    let product: Product
    @EnvironmentObject var viewModel: ShopViewModel
    
    @Environment(\.modelContext) private var modelContext
    @Query private var favorites: [FavoriteProduct]
    
    @State private var quantity: Int = 1
    
    var isFavorite: Bool {
        favorites.contains { $0.id == product.id }
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                AsyncImage(url: URL(string: product.thumbnail)) { image in
                    image.resizable().aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
                .frame(maxHeight: 300)
                .background(Color.gray.opacity(0.1))
                
                VStack(alignment: .leading, spacing: 15) {
                    HStack {
                        Text(product.title).font(.title).bold()
                        Spacer()
                        Text(product.formattedPrice).font(.title2).foregroundColor(.blue)
                    }
                    
                    Text("Description").font(.headline)
                    Text(product.description).foregroundColor(.secondary)
                    
                    Divider()
                    
                    HStack {
                        Text("Quantity")
                        Spacer()
                        Button("-") { if quantity > 1 { quantity -= 1 } }
                            .font(.title)
                            .padding(.horizontal)
                        Text("\(quantity)").font(.title3)
                        Button("+") { quantity += 1 }
                            .font(.title)
                            .padding(.horizontal)
                    }
                    
                    Divider()
                    
                    HStack {
                        Button(action: toggleFavorite) {
                            Image(systemName: isFavorite ? "heart.fill" : "heart")
                                .font(.title)
                                .foregroundColor(isFavorite ? .red : .gray)
                                .padding()
                                .background(Color.gray.opacity(0.1))
                                .clipShape(Circle())
                        }
                        
                        Button(action: {
                            viewModel.addToCart(product: product, quantity: quantity)
                        }) {
                            Text("Add to Cart")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                        }
                    }
                }
                .padding()
            }
        }
    }
    
    func toggleFavorite() {
        if isFavorite {
            if let fav = favorites.first(where: { $0.id == product.id }) {
                modelContext.delete(fav)
            }
        } else {
            let newFav = FavoriteProduct(id: product.id, title: product.title, price: product.price, thumbnail: product.thumbnail)
            modelContext.insert(newFav)
        }
    }
}
