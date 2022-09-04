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

// MARK: - SortOptions
enum SortOptions: String, CaseIterable {
    case title
    case releaseDate
    case rating
    
    var displayText: String {
        switch self {
            case .title:
                return "Title"
            case .releaseDate:
                return "Release Date"
            case .rating:
                return "Rating"
        }
    }
}

// MARK: - SortDirection
enum SortDirection: CaseIterable {
    case ascending
    case descending
    
    var value: Bool {
        switch self {
            case .ascending:
                return true
            case .descending:
                return false
        }
    }
    
    var displayText: String {
        switch self {
            case .ascending:
                return "Ascending"
            case .descending:
                return "Descending"
        }
    }
}

// MARK: - MovieListViewModel
final class MovieListViewModel: NSObject, ObservableObject {
    @Published var movies: [MovieViewModel] = []
    
    @Published var selectedSortOption: SortOptions = .title
    @Published var selectedSortDirection: SortDirection = .ascending
    @Published var filterEnabled: Bool = false
    @Published var sortEnabled: Bool = false
    
    private var fetchResultController: NSFetchedResultsController<Movie>!
    
}

// MARK: - Public
extension MovieListViewModel {
    func getAllMovies() {
        let request: NSFetchRequest<Movie> = Movie.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        fetchResultController = NSFetchedResultsController(fetchRequest: request,
                                                           managedObjectContext: CoreDataStack.shared.viewContext,
                                                           sectionNameKeyPath: nil,
                                                           cacheName: nil)
        fetchResultController.delegate = self
        
        try? fetchResultController.performFetch()
        
        DispatchQueue.main.async {
            self.movies = (self.fetchResultController.fetchedObjects ?? []).map { MovieViewModel(movie: $0) }
        }
    }
    
    func deleteMovie(_ movie: MovieViewModel) {
        let movie: Movie? = Movie.modelWith(id: movie.id)
        movie?.delete()
    }
    
    func sort() {
        let request: NSFetchRequest<Movie> = Movie.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: selectedSortOption.rawValue, ascending:  selectedSortDirection.value)]
        
        // Sort by title and then sort by rating
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true), NSSortDescriptor(key: "rating", ascending: false)]
        
        let fetchedResultsController: NSFetchedResultsController<Movie> = NSFetchedResultsController(fetchRequest: request,
                                                                                                     managedObjectContext: CoreDataStack.shared.viewContext,
                                                                                                     sectionNameKeyPath: nil,
                                                                                                     cacheName: nil)
        
        try? fetchedResultsController.performFetch()
        
        DispatchQueue.main.async {
            self.movies = (fetchedResultsController.fetchedObjects ?? []).map { MovieViewModel(movie: $0) }
        }
    }
}

// MARK: - NSFetchedResultsControllerDelegate
extension MovieListViewModel: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        DispatchQueue.main.async {
            self.movies = (controller.fetchedObjects as? [Movie] ?? []).map { MovieViewModel(movie: $0) }
        }
    }
}
