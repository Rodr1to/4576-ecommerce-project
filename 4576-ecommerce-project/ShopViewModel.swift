//
//  ShopViewModel.swift
//  4576-ecommerce-project
//
import Foundation

@MainActor
class ShopViewModel: ObservableObject {
    

    @Published var products: [Product] = []
    @Published var cartItems: [CartItem] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    

    private let productRepository = ProductRepository.shared
    

    init() {
        Task {
            await loadProducts()
        }
    }
    
    
    func loadProducts() async {
        isLoading = true
        errorMessage = nil
        
        do {
            self.products = try await productRepository.fetchProducts()
            self.isLoading = false
        } catch {
            self.errorMessage = error.localizedDescription
            self.isLoading = false
        }
    }
    
    func toggleFavorite(for product: Product) {
        if let index = products.firstIndex(where: { $0.id == product.id }) {
            products[index].isFavorite.toggle()
        }
    }
    
    func addToCart(product: Product, quantity: Int = 1) {
        if let index = cartItems.firstIndex(where: { $0.product.id == product.id }) {
            cartItems[index].quantity += quantity
        } else {
            cartItems.append(CartItem(product: product, quantity: quantity))
        }
    }
    
    func removeFromCart(cartItem: CartItem) {
        cartItems.removeAll { $0.id == cartItem.id }
    }
    
    var totalCartAmount: Double {
        cartItems.reduce(0) { $0 + ($1.product.price * Double($1.quantity)) }
    }
    
    var favoriteProducts: [Product] {
        products.filter { $0.isFavorite }
    }
}
