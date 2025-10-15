//
//  ShopViewModel.swift
//  4576-ecommerce-project
//
//  Created by Rodrigo Valverde on 10/14/2025.
//

import Foundation

// We use ObservableObject so that SwiftUI can react to its changes.
class ShopViewModel: ObservableObject {
    
    // @Published notifies the views every time these arrays change.
    @Published var products: [Product]
    @Published var cartItems: [CartItem] = []
    
    // Sample data as required
    init() {
        self.products = [
            Product(name: "Kynlee Lip Kit", image: "product1", description: "A beautiful lip kit for all occasions. Long-lasting and vibrant colors.", price: 29.99),
            Product(name: "Eyeshadow Palette", image: "product2", description: "A versatile eyeshadow palette with 12 amazing shades.", price: 44.50),
            Product(name: "Foundation Pro", image: "product3", description: "Full coverage foundation with a natural matte finish.", price: 35.00),
            Product(name: "Blush & Glow", image: "product4", description: "A compact blush that gives a natural and healthy glow.", price: 22.99),
            Product(name: "Skincare Serum", image: "product5", description: "Hydrating and rejuvenating serum for all skin types.", price: 55.00),
            Product(name: "Pro Brush Set", image: "product6", description: "A professional set of 5 essential makeup brushes.", price: 49.99)
        ]
    }
    
    // --- Functions to interact with the data ---
    
    // Toggles a product's favorite status.
    func toggleFavorite(for product: Product) {
        if let index = products.firstIndex(where: { $0.id == product.id }) {
            products[index].isFavorite.toggle()
        }
    }
    
    // Adds a product to the cart.
    func addToCart(product: Product, quantity: Int = 1) {
        // Check if the product is already in the cart.
        if let index = cartItems.firstIndex(where: { $0.product.id == product.id }) {
            // If it is, just increase the quantity.
            cartItems[index].quantity += quantity
        } else {
            // If not, add it as a new item.
            cartItems.append(CartItem(product: product, quantity: quantity))
        }
    }
    
    // Removes an item from the cart.
    func removeFromCart(cartItem: CartItem) {
        cartItems.removeAll { $0.id == cartItem.id }
    }
    
    // Calculates the total amount for the items in the cart.
    var totalCartAmount: Double {
        cartItems.reduce(0) { $0 + ($1.product.price * Double($1.quantity)) }
    }
}
