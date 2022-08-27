//
//  ActorDetailScreen.swift
//  MovieAppCoreDataSwiftUI
//
//  Created by Nikita on 27.08.22.
//

import SwiftUI

struct ActorDetailScreen: View {
    let actor: ActorViewModel
    
    var body: some View {
        VStack {
            List(actor.movies, id: \.id) { movie in
                MovieCell(movie: movie)
            }.listStyle(.plain)
        }.navigationTitle(actor.name)
    }
}

struct ActorDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        ActorDetailScreen(actor: .init(actor: .init(context: Actor.viewContext)))
    }
}
