//
//  Product.swift
//  4576-ecommerce-project
//
//  Created by Rodrigo Valverde on 10/14/2025.
//

import Foundation

// The model for a single product.
// 'Identifiable' is crucial for it to work well in SwiftUI lists.
struct Product: Identifiable {
    let id = UUID() // Unique identifier for each product
    var name: String
    var image: String
    var description: String
    var price: Double
    var isFavorite: Bool = false
}
