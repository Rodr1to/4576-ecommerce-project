import Foundation


class ShopViewModel: ObservableObject {
    
    
    @Published var products: [Product]
    @Published var cartItems: [CartItem] = []
    
    // datos de ejemplo
    init() {
        self.products = [
            Product(name: "Primer Power Grip", image: "product1", description: "Un primer en gel que hidrata y prepara tu piel para un maquillaje duradero.", price: 10.00),
            Product(name: "Base Face Colour", image: "product2", description: "Base de maquillaje fluida con acabado luminoso y natural.", price: 38.50),
            Product(name: "Máscara de Pestañas", image: "product3", description: "Máscara que alarga y da volumen a tus pestañas para una mirada impactante.", price: 28.00),
            Product(name: "Máscara All-in-One", image: "product4", description: "Fórmula todo en uno que define, alarga y da volumen sin grumos.", price: 15.99),
            Product(name: "Corrector Camo", image: "product5", description: "Corrector de alta cobertura con acabado mate que dura todo el día.", price: 7.00),
            Product(name: "Bálsamo Labial", image: "product6", description: "Bálsamo labial con un toque de color que hidrata y suaviza tus labios.", price: 24.00)
        ]
    }
    
    // interaccion con datos
    
    // favorito
    func toggleFavorite(for product: Product) {
        if let index = products.firstIndex(where: { $0.id == product.id }) {
            products[index].isFavorite.toggle()
        }
    }
    
    // añadir producto al carrito
    func addToCart(product: Product, quantity: Int = 1) {
        if let index = cartItems.firstIndex(where: { $0.product.id == product.id }) {
            cartItems[index].quantity += quantity
        } else {
            cartItems.append(CartItem(product: product, quantity: quantity))
        }
    }
    
    // eliminar item del carrito
    func removeFromCart(cartItem: CartItem) {
        cartItems.removeAll { $0.id == cartItem.id }
    }
    
    // calcular el total
    var totalCartAmount: Double {
        cartItems.reduce(0) { $0 + ($1.product.price * Double($1.quantity)) }
    }
}
