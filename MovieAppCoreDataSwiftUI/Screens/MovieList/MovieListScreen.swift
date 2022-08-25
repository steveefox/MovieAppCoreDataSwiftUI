//
//  MovieListScreen.swift
//  MovieAppCoreDataSwiftUI
//
//  Created by Nikita on 23.08.22.
//

import SwiftUI

struct MovieListScreen: View {
    @StateObject private var viewModel: MovieListViewModel = MovieListViewModel()
    
    @State private var isPresented: Bool = false
    
    private func deleteMovie(at indexSet: IndexSet) {
        indexSet.forEach { index in
            let movie = viewModel.movies[index]
            
            viewModel.deleteMovie(movie)
            viewModel.getAllMovies()
        }
    }
    
    var body: some View {
        List {
            ForEach(viewModel.movies, id: \.id) { movie in
                NavigationLink(destination: ReviewListScreen(movie: movie)) {
                    MovieCell(movie: movie)
                }
                
            }.onDelete(perform: deleteMovie(at:))
        }.listStyle(PlainListStyle())
        .navigationTitle("Movies")
        .navigationBarItems(trailing: Button("Add Movie") {
            isPresented = true
        })
        .sheet(isPresented: $isPresented, onDismiss: {
            viewModel.getAllMovies()
        },  content: {
            AddMovieScreen()
        })
        .embedInNavigationView()
        
        .onAppear(perform: {
            viewModel.getAllMovies()
        })
    }
}

struct MovieListScreen_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MovieListScreen()
        }
    }
}

struct MovieCell: View {
    let movie: MovieViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(movie.title)
                    .fontWeight(.bold)
                Text(movie.director)
                    .font(.caption2)
                Text(movie.releaseDate ?? "")
                    .font(.caption)
            }
            Spacer()
            RatingView(rating: .constant(movie.rating))
        }
    }
}
