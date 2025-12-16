//
//  ProductRepository.swift
//  4576-ecommerce-project
//
import Foundation

class MovieRepository {
    private let apiKey = "3cae426b920b29ed2fb1c0749f258325"
    
    func searchMovies(query: String) async throws -> [Movie] {
        guard !query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return []
        }
        
        guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            throw URLError(.badURL)
        }
        
        let urlString = "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&query=\(encodedQuery)"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decodedResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
        return decodedResponse.results
    }
}
