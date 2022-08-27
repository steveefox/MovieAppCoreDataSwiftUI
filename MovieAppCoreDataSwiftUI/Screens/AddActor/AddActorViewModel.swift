//
//  AddActorViewModel.swift
//  MovieAppCoreDataSwiftUI
//
//  Created by Nikita on 27.08.22.
//

import Foundation
import CoreData

final class AddActorViewModel: ObservableObject {
    
    var name: String = ""
     
    func addActorToMovieWith(id: NSManagedObjectID) {
        guard let movie: Movie = Movie.modelWith(id: id) else { return }
        
        let actor = Actor(context: Actor.viewContext)
        actor.name = name
        actor.addToMovies(movie)
        
        actor.save()
    }
    
}
