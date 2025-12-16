//
//  Product.swift
//  4576-ecommerce-project
//
import Foundation

struct MovieResponse: Decodable {
    let results: [Movie]
}

struct Movie: Decodable, Identifiable, Hashable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let releaseDate: String?
    let voteAverage: Double
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }
    
    var fullPosterURL: URL? {
        guard let path = posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(path)")
    }
    
    var formattedScore: String {
        return String(format: "%.1f", voteAverage)
    }
}
