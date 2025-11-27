//
//  ShopViewModel.swift
//  4576-ecommerce-project
//
import Foundation
import SwiftUI

@MainActor
class ShopViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var cart: [Product: Int] = [:] // Producto : Cantidad
    @Published var isLoading = false
    
    private let repository = ProductRepository()
    
    // Cálculo del total
    var cartTotal: Double {
        cart.reduce(0) { sum, item in
            sum + (item.key.price * Double(item.value))
        }
    }
    
    // Cargar productos
    func fetchProducts() async {
        isLoading = true
        do {
            self.products = try await repository.getProducts()
        } catch {
            print("Error cargando productos: \(error)")
        }
        isLoading = false
    }
    
    // MARK: - Lógica del Carrito
    
    // Agregar producto (desde Detalle o Carrito)
    func addToCart(product: Product, quantity: Int = 1) {
        if let currentQty = cart[product] {
            cart[product] = currentQty + quantity
        } else {
            cart[product] = quantity
        }
    }
    
    // Restar uno del carrito
    func decrementFromCart(product: Product) {
        guard let currentQty = cart[product] else { return }
        
        if currentQty > 1 {
            cart[product] = currentQty - 1
        } else {
            // Si llega a 0, ¿lo borramos? Generalmente sí.
            cart.removeValue(forKey: product)
        }
    }
    
    // Eliminar completamente
    func removeFromCart(product: Product) {
        cart.removeValue(forKey: product)
    }
}
