//
//  ProductDetailView.swift
//  4576-ecommerce-project
//
import SwiftUI

struct MovieDetailView: View {
    let movie: Movie
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                AsyncImage(url: movie.fullPosterURL) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ZStack {
                        Color.gray.opacity(0.3)
                        ProgressView()
                    }
                }
                .frame(maxHeight: 450)
                .cornerRadius(12)
                .shadow(radius: 5)
                .frame(maxWidth: .infinity)
                
                VStack(alignment: .leading, spacing: 15) {
                    Text(movie.title)
                        .font(.title)
                        .bold()
                        .multilineTextAlignment(.leading)
                    
                    HStack {
                        Label(movie.releaseDate ?? "Sin fecha", systemImage: "calendar")
                            .foregroundColor(.secondary)
                        
                        Spacer()
                        
                        Label(movie.formattedScore, systemImage: "star.fill")
                            .foregroundColor(.yellow)
                            .bold()
                    }
                    .font(.subheadline)
                    
                    Divider()
                    
                    Text("Sinopsis")
                        .font(.headline)
                    
                    Text(movie.overview.isEmpty ? "No hay descripción disponible." : movie.overview)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .lineSpacing(5)
                }
                .padding()
            }
        }
        .navigationTitle("Detalle")
        .navigationBarTitleDisplayMode(.inline)
    }
}
