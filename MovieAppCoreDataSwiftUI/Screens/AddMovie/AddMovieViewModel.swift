//
//  AddMovieViewModel.swift
//  MovieAppCoreDataSwiftUI
//
//  Created by Nikita on 23.08.22.
//

import Foundation

final class AddMovieViewModel: ObservableObject {
    var title: String = ""
    var director: String = ""
    @Published var rating: Int?
    var releaseDate: Date = Date()
}

// MARK: - Public
extension AddMovieViewModel {
    func save() {
        let movie: Movie = Movie(context: Movie.viewContext)
        movie.title = title
        movie.director = director
        movie.rating = Double(rating ?? .zero)
        movie.releaseDate = releaseDate
        
        movie.save()
    }
}
