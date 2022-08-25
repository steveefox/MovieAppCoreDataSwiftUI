//
//  AddReviewViewModel.swift
//  MovieAppCoreDataSwiftUI
//
//  Created by Nikita on 24.08.22.
//

import Foundation

class AddReviewViewModel: ObservableObject {
    var title: String = ""
    var text: String = ""
}

// MARK: - Public
extension AddReviewViewModel {
    func addReviewFor(movie: MovieViewModel) {
        guard let movie: Movie = Movie.modelWith(id: movie.id) else { return }
        
        let review = Review(context: Movie.viewContext)
        review.title = title
        review.text = text
        review.movie = movie
        
        review.save()
    }
}
