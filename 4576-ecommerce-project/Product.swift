//
//  Product.swift
//  4576-ecommerce-project
//
import Foundation
import SwiftData

struct ProductResponse: Decodable {
    let products: [Product]
}

struct Product: Decodable, Identifiable, Hashable {
    let id: Int
    let title: String
    let description: String
    let price: Double
    let thumbnail: String
    let images: [String]
    
    // Ayuda visual para el precio
    var formattedPrice: String {
        return "$\(String(format: "%.2f", price))"
    }
}

@Model
class FavoriteProduct {
    @Attribute(.unique) var id: Int
    var title: String
    var price: Double
    var thumbnail: String
    
    init(id: Int, title: String, price: Double, thumbnail: String) {
        self.id = id
        self.title = title
        self.price = price
        self.thumbnail = thumbnail
    }
}
