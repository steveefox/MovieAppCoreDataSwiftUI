//
//  MovieListViewModel.swift
//  MovieAppCoreDataSwiftUI
//
//  Created by Nikita on 23.08.22.
//

import Foundation
import CoreData

// MARK: - MovieViewModel
struct MovieViewModel {
    let movie: Movie
    
    var id: NSManagedObjectID {
        return movie.objectID
    }
    
    var title: String {
        return movie.title ?? ""
    }
    
    var director: String {
        return movie.director ?? ""
    }
    
    var releaseDate: String? {
        guard let movieDate = movie.releaseDate else { return nil }
        
        return DateFormatterHelper.formattedString(from: movieDate)
    }
    
    var rating: Int? {
        return Int(movie.rating)
    }
}

// MARK: - MovieListViewModel
final class MovieListViewModel: ObservableObject {
    @Published var movies: [MovieViewModel] = []
    
}

// MARK: - Public
extension MovieListViewModel {
    func getAllMovies() {
        let movies: [Movie] = Movie.allObjects()
        DispatchQueue.main.async {
            self.movies = movies.map { MovieViewModel(movie: $0) }
        }
    }
    
    func deleteMovie(_ movie: MovieViewModel) {
        let movie: Movie? = Movie.modelWith(id: movie.id)
        movie?.delete()
    }
}
