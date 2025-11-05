//
//  HomeView.swift
//  4576-ecommerce-project
//
import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: ShopViewModel
    
    private let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Image("banner")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(20)
                        .padding(.horizontal)
                    
                    Text("Products")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                    
                    if viewModel.isLoading {
                        ProgressView()
                            .frame(maxWidth: .infinity)
                    } else if let errorMessage = viewModel.errorMessage {
                        Text("Error al cargar productos: \(errorMessage)")
                            .padding()
                    } else {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(viewModel.products) { product in
                                NavigationLink(destination: ProductDetailView(product: product)) {
                                    ProductCard(product: product)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("Welcome!")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if viewModel.errorMessage != nil {
                    Button("Retry") {
                        Task {
                            await viewModel.loadProducts()
                        }
                    }
                }
            }
        }
    }
}

struct ProductCard: View {
    @EnvironmentObject var viewModel: ShopViewModel
    let product: Product
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .topTrailing) {
                AsyncImage(url: URL(string: product.thumbnail)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(12)
                } placeholder: {
                    ProgressView()
                        .frame(height: 150)
                }
                
                Button(action: {
                    viewModel.toggleFavorite(for: product)
                }) {
                    Image(systemName: product.isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(product.isFavorite ? .red : .primary)
                        .padding(8)
                        .background(.thinMaterial)
                        .clipShape(Circle())
                }
                .padding(8)
            }
            
            Text(product.title)
                .font(.headline)
                .foregroundColor(.primary)
                .lineLimit(1) 
            
            Text("$\(product.price, specifier: "%.2f")")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    MainView()
}
