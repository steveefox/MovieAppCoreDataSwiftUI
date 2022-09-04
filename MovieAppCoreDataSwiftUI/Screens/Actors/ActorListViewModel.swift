//
//  ActorListViewModel.swift
//  MovieAppCoreDataSwiftUI
//
//  Created by Nikita on 27.08.22.
//

import Foundation
import CoreData

struct ActorViewModel {
    let actor: Actor
    
    var actorId: NSManagedObjectID {
        actor.objectID
    }
    
    var name: String {
        return actor.name ?? ""
    }
    
    var movies: [MovieViewModel] {
        Movie.getMoviesForActorWith(name: name).map { MovieViewModel(movie: $0) }
    }
}

final class ActorListViewModel: ObservableObject {
    @Published var actors: [ActorViewModel] = []
}

// MARK: - Public
extension ActorListViewModel {
    func getActorsFor(movie: MovieViewModel) {
        DispatchQueue.main.async {
            self.actors = Actor.getActorsForMovieWith(id: movie.id).map { ActorViewModel(actor: $0) }
        }
    }
}
