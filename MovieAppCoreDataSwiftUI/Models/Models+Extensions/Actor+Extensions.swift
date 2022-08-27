//
//  Actor+Extensions.swift
//  MovieAppCoreDataSwiftUI
//
//  Created by Nikita on 27.08.22.
//

import Foundation
import CoreData

extension Actor: BaseCoreDataModel {}

extension Actor {
    static func getActorsForMovieWith(id: NSManagedObjectID) -> [Actor] {
        guard let movie: Movie = Movie.modelWith(id: id),
              let actors = movie.actors else { return [] }
        
        return (actors.allObjects as? [Actor]) ?? []
    }
}
