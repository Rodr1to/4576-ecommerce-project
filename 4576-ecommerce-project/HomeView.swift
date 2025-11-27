//
//  HomeView.swift
//  4576-ecommerce-project
//
import SwiftUI
import SwiftData


struct HomeView: View {

    @EnvironmentObject var viewModel: ShopViewModel

    let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    ZStack(alignment: .bottomLeading) {
                        Color.blue.opacity(0.8)
                            .frame(height: 180)
                            .cornerRadius(12)

                        HStack {
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Special Offer")
                                    .foregroundColor(.white.opacity(0.8))
                                Text("25% OFF")
                                    .font(.largeTitle).bold()
                                    .foregroundColor(.white)
                                Button("Shop now") { }
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(Color.white)
                                    .cornerRadius(15)
                                    .foregroundColor(.blue)
                            }
                            .padding()
                            
                            Spacer()
                        }
                    }
                    .padding(.horizontal)

                    
                    HStack {
                        Text("Products").font(.title2).bold()
                        Spacer()
                    }
                    .padding(.horizontal)

                    
                    if viewModel.isLoading {
                        ProgressView()
                    } else {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(viewModel.products) { product in
                                NavigationLink(destination: ProductDetailView(product: product)
                                    .environmentObject(viewModel)
                                ) {
                                    ProductItemView(product: product)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .navigationTitle("Home")
            .task {

                if viewModel.products.isEmpty {
                    await viewModel.fetchProducts()
                }
            }
        }
    }
}



struct ProductItemView: View {
    let product: Product
    

    @Environment(\.modelContext) private var modelContext
    @Query private var favorites: [FavoriteProduct]
    
    var isFavorite: Bool {
        favorites.contains { $0.id == product.id }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .topTrailing) {
                AsyncImage(url: URL(string: product.thumbnail)) { img in
                    img.resizable().aspectRatio(contentMode: .fill)
                } placeholder: { Color.gray.opacity(0.2) }
                .frame(height: 140)
                .clipped()
                
                Button(action: toggleFavorite) {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .padding(8)
                        .foregroundColor(isFavorite ? .red : .white)
                        .background(Color.black.opacity(0.3))
                        .clipShape(Circle())
                }
                .padding(8)
            }
            .cornerRadius(10)
            
            Text(product.title)
                .font(.headline)
                .lineLimit(1)
            
            Text(product.formattedPrice)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .background(Color(UIColor.systemBackground))
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
