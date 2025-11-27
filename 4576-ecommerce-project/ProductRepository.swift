//
//  ProductRepository.swift
//  4576-ecommerce-project
//
import Foundation

class ProductRepository {

    func getProducts() async throws -> [Product] {
        guard let url = URL(string: "https://dummyjson.com/products") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decodedResponse = try JSONDecoder().decode(ProductResponse.self, from: data)
        return decodedResponse.products
    }
}
