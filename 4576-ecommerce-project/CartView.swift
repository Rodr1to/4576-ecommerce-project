//
//  CartView.swift
//  4576-ecommerce-project
//
import SwiftUI

struct CartView: View {
    @EnvironmentObject var viewModel: ShopViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.cart.isEmpty {
                    ContentUnavailableView("Cart Empty", systemImage: "cart")
                } else {
                    List {
                        ForEach(viewModel.cart.keys.sorted(by: { $0.id < $1.id }), id: \.self) { product in
                            HStack(spacing: 12) {
                                AsyncImage(url: URL(string: product.thumbnail)) { img in
                                    img.resizable().aspectRatio(contentMode: .fill)
                                } placeholder: { Color.gray }
                                .frame(width: 60, height: 60)
                                .cornerRadius(8)
                                
                                VStack(alignment: .leading) {
                                    Text(product.title).font(.headline).lineLimit(1)
                                    Text(product.formattedPrice).foregroundColor(.secondary)
                                }
                                
                                Spacer()
                                
                                HStack(spacing: 10) {
                                    Button(action: {
                                        viewModel.decrementFromCart(product: product)
                                    }) {
                                        Image(systemName: "minus.circle")
                                            .foregroundColor(.blue)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                    
                                    Text("\(viewModel.cart[product] ?? 0)")
                                        .bold()
                                        .frame(minWidth: 20)
                                    
                                    Button(action: {
                                        viewModel.addToCart(product: product, quantity: 1)
                                    }) {
                                        Image(systemName: "plus.circle")
                                            .foregroundColor(.blue)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                        }
                        .onDelete { indexSet in
                            let sortedProducts = viewModel.cart.keys.sorted(by: { $0.id < $1.id })
                            for index in indexSet {
                                viewModel.removeFromCart(product: sortedProducts[index])
                            }
                        }
                    }
                    
                    VStack(spacing: 16) {
                        HStack {
                            Text("Total").font(.title2).bold()
                            Spacer()
                            Text("$\(String(format: "%.2f", viewModel.cartTotal))")
                                .font(.title2).bold().foregroundColor(.blue)
                        }
                        
                        Button(action: {}) {
                            Text("Pagar ahora") 
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                        }
                    }
                    .padding()
                    .background(Color(UIColor.systemBackground))
                    .shadow(radius: 2)
                }
            }
            .navigationTitle("Cart")
        }
    }
}
