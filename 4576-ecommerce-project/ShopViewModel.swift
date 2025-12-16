//
//  ShopViewModel.swift
//  4576-ecommerce-project
//
import Foundation
import SwiftUI

@MainActor
class MoviesViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var searchText: String = ""
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
    private let repository = MovieRepository()
    
    func searchMovies() async {
        guard !searchText.isEmpty else { return }
        
        isLoading = true
        errorMessage = nil
        
        do {
            let results = try await repository.searchMovies(query: searchText)
            self.movies = results
        } catch {
            self.errorMessage = "Error al buscar: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
}
