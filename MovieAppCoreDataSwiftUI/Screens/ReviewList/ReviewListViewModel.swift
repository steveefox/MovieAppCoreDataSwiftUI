//
//  ReviewListViewModel.swift
//  MovieAppCoreDataSwiftUI
//
//  Created by Nikita on 24.08.22.
//

import Foundation
import CoreData

// MARK: - ReviewViewModel
struct ReviewViewModel {
    let review: Review
    
    var reviewId: NSManagedObjectID {
        review.objectID
    }
    
    var title: String {
        review.title ?? ""
    }
    
    var text: String {
        review.text ?? ""
    }
    
    var publishedDate: Date? {
        review.publishedAt
    }
    
}

// MARK: - ReviewListViewModel
class ReviewListViewModel: ObservableObject {
    @Published var reviews: [ReviewViewModel] = []
    
    
}

// MARK: - Public
extension ReviewListViewModel {
    func getReviewsFor(movie: MovieViewModel) {
        DispatchQueue.main.async {
            self.reviews = Review.getReviewsFor(movieId: movie.id).map { ReviewViewModel(review: $0) }
        }
    }
    
    /// bad performance logic
//    func getReviewsFor(movie: MovieViewModel) {
//        guard let movie = CoreDataManager.shared.getMovieWith(id: movie.id) else { return }
//
//        DispatchQueue.main.async {
//            self.reviews = (movie.reviews?.allObjects as! [Review]).map { ReviewViewModel(review: $0) }
//        }
//    }
}
