//
//  ProductRepository.swift
//  4576-ecommerce-project
//
import Foundation


struct ProductResponse: Codable {
    let products: [Product]
}

struct Product: Codable, Identifiable {
    let id: Int
    let title: String
    let description: String
    let price: Double
    let thumbnail: String
    

    var isFavorite: Bool = false
}
