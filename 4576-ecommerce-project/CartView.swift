//
//  CartView.swift
//  4576-ecommerce-project
//
//  Created by Rodrigo Valverde on 10/14/2025.
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
                            // Allows deleting with a swipe gesture
                            if let index = indexSet.first {
                                viewModel.removeFromCart(cartItem: viewModel.cartItems[index])
                            }
                        }
                    }
                    
                    // Total Summary
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

// A component for each row in the cart list
struct CartItemRow: View {
    let item: CartItem
    
    var body: some View {
        HStack {
            Image(item.product.image)
                .resizable()
                .frame(width: 60, height: 60)
                .cornerRadius(8)
            
            VStack(alignment: .leading) {
                Text(item.product.name).font(.headline)
                Text("$\(item.product.price, specifier: "%.2f")").font(.subheadline)
            }
            
            Spacer()
            
            Text("Qty: \(item.quantity)")
                .font(.headline)
        }
    }
}


#Preview {
    MainView()
}
