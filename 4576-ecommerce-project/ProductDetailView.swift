import SwiftUI

struct ProductDetailView: View {
    @EnvironmentObject var viewModel: ShopViewModel
    let product: Product
    @State private var quantity: Int = 1
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Image(product.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(20)
                
                HStack {
                    Text(product.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Spacer()
                    Text("$\(product.price, specifier: "%.2f")")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.secondary)
                }
                
                Text(product.description)
                    .foregroundColor(.secondary)
                
                // cantidades
                HStack {
                    Text("Quantity")
                        .font(.headline)
                    Spacer()
                    Button(action: { if quantity > 1 { quantity -= 1 } }) {
                        Image(systemName: "minus.circle")
                    }
                    Text("\(quantity)")
                        .font(.title2)
                        .fontWeight(.bold)
                        .frame(width: 50)
                    Button(action: { quantity += 1 }) {
                        Image(systemName: "plus.circle")
                    }
                }
                .font(.title)
                
                // boton de agregar
                Button(action: {
                    viewModel.addToCart(product: product, quantity: quantity)
                }) {
                    Text("Add to Cart")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(15)
                }
            }
            .padding()
        }
        .navigationTitle("Product Details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            // favoritos
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    viewModel.toggleFavorite(for: product)
                }) {
                    let isFavorite = viewModel.products.first { $0.id == product.id }?.isFavorite ?? false
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(isFavorite ? .red : .primary)
                }
            }
        }
    }
}

#Preview {
    NavigationView {
        ProductDetailView(product: ShopViewModel().products[0])
            .environmentObject(ShopViewModel())
    }
}
