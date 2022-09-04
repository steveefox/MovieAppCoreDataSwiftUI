//
//  FiltersViewModel.swift
//  MovieAppCoreDataSwiftUI
//
//  Created by Nikita on 30.08.22.
//

import Foundation

class FiltersViewModel: ObservableObject {
    
    func filterMovieBy(releaseDate: Date) -> [MovieViewModel] {
        return Movie.getMoviesWith(releaseDate: releaseDate).map { MovieViewModel(movie: $0) }
    }
    
    func filterMovieByReleaseDateRange(lowerBoundDate: Date, upperBoundDate: Date) -> [MovieViewModel] {
        return Movie.getMoviesWithReleaseDateRange(lower: lowerBoundDate, upper: upperBoundDate).map { MovieViewModel(movie: $0) }
    }
    
    func filterMoviesBy(lowerDate: Date?, upperDate: Date?, orMinimumRating minimumRating: Int?) -> [MovieViewModel] {
        return Movie.getMoviesBy(lowerDate: lowerDate, upperDate: upperDate, orMinimumRating: minimumRating).map { MovieViewModel(movie: $0) }
    }
    
    func filterMoviesBy(title: String) -> [MovieViewModel] {
        return Movie.getMoviesBy(title: title).map { MovieViewModel(movie: $0) }
    }
    
    func filerMoviesBy(actorName: String) -> [MovieViewModel] {
        return Movie.getMoviesForActorWith(name: actorName).map { MovieViewModel(movie: $0) }
    }
    
    func filterBy(minimumReviewCount: Int) -> [MovieViewModel] {
        return Movie.getMoviesBy(minimumReviewCount: minimumReviewCount).map { MovieViewModel(movie: $0) }
    }
}
