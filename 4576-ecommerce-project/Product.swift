//
//  Product.swift
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
    

    enum CodingKeys: String, CodingKey {
        case id, title, description, price, thumbnail
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.description = try container.decode(String.self, forKey: .description)
        self.price = try container.decode(Double.self, forKey: .price)
        self.thumbnail = try container.decode(String.self, forKey: .thumbnail)
        
        self.isFavorite = false
    }

    init(id: Int, title: String, description: String, price: Double, thumbnail: String, isFavorite: Bool = false) {
        self.id = id
        self.title = title
        self.description = description
        self.price = price
        self.thumbnail = thumbnail
        self.isFavorite = isFavorite
    }
}
