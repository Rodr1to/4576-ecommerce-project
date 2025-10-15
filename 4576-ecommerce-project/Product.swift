import Foundation

struct Product: Identifiable {
    let id = UUID()
    var name: String
    var image: String
    var description: String
    var price: Double
    var isFavorite: Bool = false
}
