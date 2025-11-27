//
//  FavoritesView.swift
//  4576-ecommerce-project
//
import SwiftUI
import SwiftData

struct FavoritesView: View {
    @Query var favorites: [FavoriteProduct]
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(favorites) { fav in
                    HStack {
                        AsyncImage(url: URL(string: fav.thumbnail)) { img in
                            img.resizable().aspectRatio(contentMode: .fill)
                        } placeholder: { Color.gray }
                        .frame(width: 60, height: 60)
                        .cornerRadius(8)
                        
                        VStack(alignment: .leading) {
                            Text(fav.title).font(.headline)
                            Text("$\(String(format: "%.2f", fav.price))").foregroundColor(.blue)
                        }
                    }
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        modelContext.delete(favorites[index])
                    }
                }
            }
            .navigationTitle("Favorites")
            .overlay {
                if favorites.isEmpty {
                    ContentUnavailableView("No Favorites", systemImage: "heart.slash")
                }
            }
        }
    }
}
