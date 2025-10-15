import SwiftUI

struct CartView: View {
    @EnvironmentObject var viewModel: ShopViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.cartItems.isEmpty {
                    Spacer()
                    Text("Your cart is empty.")
                        .foregroundColor(.secondary)
                    Spacer()
                } else {
                    List {
                        ForEach(viewModel.cartItems) { item in
                            CartItemRow(item: item)
                        }
                        .onDelete { indexSet in
                            // borrar con swipe
                            if let index = indexSet.first {
                                viewModel.removeFromCart(cartItem: viewModel.cartItems[index])
                            }
                        }
                    }
                    .listStyle(.plain)
                    
                    // total
                    VStack(spacing: 15) {
                        HStack {
                            Text("Total")
                                .font(.title2)
                                .fontWeight(.semibold)
                            Spacer()
                            Text("$\(viewModel.totalCartAmount, specifier: "%.2f")")
                                .font(.title2)
                                .fontWeight(.bold)
                        }
                        
                        Button(action: {}) {
                            Text("Pagar ahora")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(15)
                        }
                    }
                    .padding()
                    .background(.thinMaterial)
                }
            }
            .navigationTitle("My Cart")
        }
    }
}

struct CartItemRow: View {
    let item: CartItem
    
    var body: some View {
        HStack(spacing: 15) {
            Image(item.product.image)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(item.product.name)
                    .font(.headline)
                
                Text("$\(item.product.price, specifier: "%.2f")")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Text("Qty: \(item.quantity)")
                .font(.headline)
        }
        .padding(.vertical, 8)
    }
}


#Preview {
    MainView()
}
