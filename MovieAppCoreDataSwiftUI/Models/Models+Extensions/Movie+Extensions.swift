//
//  Movie+Extensions.swift
//  MovieAppCoreDataSwiftUI
//
//  Created by Nikita on 25.08.22.
//

import Foundation
import CoreData

extension Movie: BaseCoreDataModel {}

extension Movie {
    static func getMoviesForActorWith(name: String) -> [Movie] {
        let request: NSFetchRequest<Movie> = Movie.fetchRequest()
//        request.predicate = NSPredicate(format: "actors.name CONTAINS %@", name)
//        request.predicate = NSPredicate(format: "%K.name CONTAINS %@", #keyPath(Movie.actors), name)
        request.predicate = NSPredicate(format: "%K.%K CONTAINS %@", #keyPath(Movie.actors), #keyPath(Actor.name), name)
        
        do {
            return try viewContext.fetch(request)
        } catch {
            print("Failed to load all movies for actor \(name) with error \(error)")
            return []
        }
    }
    
    static func getMoviesWith(releaseDate: Date) -> [Movie] {
        let request: NSFetchRequest<Movie> = Movie.fetchRequest()
        request.predicate = NSPredicate(format: "%K >= %@", #keyPath(Movie.releaseDate), releaseDate as NSDate)
        
        do {
            return try viewContext.fetch(request)
        } catch {
            print("Failed to fetch movies by release date with \(error)")
            return []
        }
    }
    
    static func getMoviesWithReleaseDateRange(lower: Date, upper: Date) -> [Movie] {
        let request: NSFetchRequest<Movie> = Movie.fetchRequest()
        request.predicate = NSPredicate(format: "%K >= %@ AND %K <= %@",
                                        #keyPath(Movie.releaseDate),
                                        lower as NSDate,
                                        #keyPath(Movie.releaseDate),
                                        upper as NSDate)
        
        do {
            return try viewContext.fetch(request)
        } catch {
            print("Failed to fetch movies by release date range wirth \(error)")
            return []
        }
    }
    
    static func getMoviesBy(lowerDate: Date?, upperDate: Date?, orMinimumRating minimumRating: Int?) -> [Movie] {
        var predicates: [NSPredicate] = []
        
        if let lowerDate = lowerDate, let upperDate = upperDate {
            let dateRangePredicate = NSPredicate(format: "%K >= %@ AND %K <= %@",
                                                 #keyPath(Movie.releaseDate),
                                                 lowerDate as NSDate,
                                                 #keyPath(Movie.releaseDate),
                                                 upperDate as NSDate)
            predicates.append(dateRangePredicate)
        } else if let minimumRating = minimumRating {
            let minimumRatingPredicate = NSPredicate(format: "%K >= %i", #keyPath(Movie.rating), minimumRating)
            predicates.append(minimumRatingPredicate)
        }
        
        let request: NSFetchRequest<Movie> = Movie.fetchRequest()
        request.predicate = NSCompoundPredicate(orPredicateWithSubpredicates: predicates)
        
        do {
            return try viewContext.fetch(request)
        } catch {
            print("Failed to fech movies by release date range or minimum rating with \(error)")
            return []
        }
    }
    
    static func getMoviesBy(title: String) -> [Movie] {
        let request: NSFetchRequest<Movie> = Movie.fetchRequest()
        request.predicate = NSPredicate(format: "%K BEGINSWITH[cd] %@", #keyPath(Movie.title), title)
        
        do {
            return try viewContext.fetch(request)
        } catch {
            print("Failed to fech movies by title with \(error)")
            return []
        }
    }
    
    static func getMoviesBy(minimumReviewCount: Int = 1) -> [Movie] {
        let request: NSFetchRequest<Movie> = Movie.fetchRequest()
        request.predicate = NSPredicate(format: "%K.@count >= %i", #keyPath(Movie.reviews), minimumReviewCount)
        
        do {
            return try viewContext.fetch(request)
        } catch {
            print("Failed to fech movies by minimum review count with \(error)")
            return []
        }
    }
}
