//
//  CartItem.swift
//  4576-ecommerce-project
//
//  Created by Rodrigo Valverde on 10/14/2025.
//

import Foundation

// The model for an item within the shopping cart.
// It needs its own ID so we can list multiple items.
struct CartItem: Identifiable {
    let id = UUID()
    var product: Product
    var quantity: Int
}
