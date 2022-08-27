//
//  MovieDetailScreen.swift
//  MovieAppCoreDataSwiftUI
//
//  Created by Nikita on 27.08.22.
//

import SwiftUI

enum MovieDetailsRoutes: Identifiable, CaseIterable {
    
    var id: UUID {
        return UUID()
    }
    
    case reviews
    case actors
}

extension MovieDetailsRoutes {
    
    var displayText: String {
        switch self {
            case .reviews:
                return "Reviews"
            case .actors:
                return "Actors"
        }
    }
}

struct MovieDetailScreen: View {
    
    let movie: MovieViewModel
    
    var body: some View {
        VStack {
            List {
                NavigationLink(
                    destination: ReviewListScreen(movie: movie),
                    label: {
                        Text("Reviews")
                    })
                
                NavigationLink(
                    destination: ActorListScreen(movie: movie),
                    label: {
                        Text("Actors")
                    })
                
            }.listStyle(PlainListStyle())
        }.navigationTitle(movie.title)
    }
}

struct MovieDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailScreen(movie: MovieViewModel(movie: Movie(context: CoreDataStack.shared.viewContext)))
            .embedInNavigationView()
    }
}
