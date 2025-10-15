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
                    // banner
                    Image("banner")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(20)
                        .padding(.horizontal)
                    
                    // productos
                    Text("Products")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                    
                    // grid
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(viewModel.products) { product in
                            NavigationLink(destination: ProductDetailView(product: product)) {
                                ProductCard(product: product)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
            .navigationTitle("Welcome!")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ProductCard: View {
    @EnvironmentObject var viewModel: ShopViewModel
    let product: Product
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .topTrailing) {
                Image(product.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(12)
                
                // favoritos
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
            
            Text(product.name)
                .font(.headline)
                .foregroundColor(.primary)
            
            Text("$\(product.price, specifier: "%.2f")")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    MainView() 
}
