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
    static func getAllMoviesForActorWith(name: String) -> [Movie] {
        let request: NSFetchRequest<Movie> = Movie.fetchRequest()
        request.predicate = NSPredicate(format: "actors.name CONTAINS %@", name)
        
        do {
            return try viewContext.fetch(request)
        } catch {
            print("Failed to load all movies for actor \(name) with error \(error)")
            return []
        }
    }
}
