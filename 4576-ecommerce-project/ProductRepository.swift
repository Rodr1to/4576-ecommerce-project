//
//  ProductRepository.swift
//  4576-ecommerce-project
//
import Foundation

actor ProductRepository {
    
    static let shared = ProductRepository()
        private let productsURL = URL(string: "https://dummyjson.com/products")!
    
    func fetchProducts() async throws -> [Product] {
        do {
            // llamada de red
            let (data, _) = try await URLSession.shared.data(from: productsURL)
            
            // dcodifica la respuesta
            let response = try JSONDecoder().decode(ProductResponse.self, from: data)
            
            // array de productos
            return response.products
        } catch {
            // error
            print("Error fetching or decoding products: \(error)")
            throw error
        }
    }
}
