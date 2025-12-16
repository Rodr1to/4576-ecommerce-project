//
//  HomeView.swift
//  4576-ecommerce-project
//
import SwiftUI

struct MovieSearchView: View {
    @StateObject private var viewModel = MoviesViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    
                    TextField("Buscar película...", text: $viewModel.searchText)
                        .onSubmit {
                            Task { await viewModel.searchMovies() }
                        }
                    
                    if !viewModel.searchText.isEmpty {
                        Button(action: {
                            viewModel.searchText = ""
                            viewModel.movies = []
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                        }
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding()
                
                if viewModel.isLoading {
                    Spacer()
                    ProgressView("Buscando...")
                    Spacer()
                } else if let error = viewModel.errorMessage {
                    Spacer()
                    Text(error)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding()
                    Spacer()
                } else if viewModel.movies.isEmpty {
                    Spacer()
                    VStack(spacing: 10) {
                        Image(systemName: "popcorn")
                            .font(.system(size: 50))
                            .foregroundColor(.gray)
                        Text("Busca tus películas favoritas")
                            .foregroundColor(.gray)
                    }
                    Spacer()
                } else {
                    List(viewModel.movies) { movie in
                        NavigationLink(destination: MovieDetailView(movie: movie)) {
                            HStack(spacing: 12) {
                                AsyncImage(url: movie.fullPosterURL) { image in
                                    image.resizable().aspectRatio(contentMode: .fill)
                                } placeholder: {
                                    Color.gray.opacity(0.3)
                                }
                                .frame(width: 60, height: 90)
                                .cornerRadius(8)
                                
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(movie.title)
                                        .font(.headline)
                                        .lineLimit(2)
                                    
                                    Text(movie.overview)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                        .lineLimit(3)
                                }
                            }
                            .padding(.vertical, 4)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Cine ISIL")
        }
    }
}
