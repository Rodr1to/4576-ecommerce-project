//
//  CartView.swift
//  4576-ecommerce-project
//
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
                            if let index = indexSet.first {
                                viewModel.removeFromCart(cartItem: viewModel.cartItems[index])
                            }
                        }
                    }
                    .listStyle(.plain)
                    
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
            AsyncImage(url: URL(string: item.product.thumbnail)) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .cornerRadius(8)
            } placeholder: {
                ProgressView()
                    .frame(width: 80, height: 80)
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text(item.product.title)
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
