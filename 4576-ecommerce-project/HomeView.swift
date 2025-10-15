import SwiftUI

struct HomeView: View {
    // We receive the ViewModel from the environment.
    @EnvironmentObject var viewModel: ShopViewModel
    
    // Columns for our product grid.
    private let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Top Banner
                    Image("banner")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(20)
                        .padding(.horizontal)
                    
                    // Products section title
                    Text("Products")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                    
                    // Products Grid
                    LazyVGrid(columns: columns, spacing: 20) {
                        // We iterate over the products from the ViewModel
                        ForEach(viewModel.products) { product in
                            // NavigationLink to go to the product detail view.
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

// A component to display each product in the grid.
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
                
                // Favorites Button
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
    MainView() // We preview from MainView to have the EnvironmentObject available
}
