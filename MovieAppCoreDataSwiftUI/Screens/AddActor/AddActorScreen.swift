//
//  AddActorScreen.swift
//  MovieAppCoreDataSwiftUI
//
//  Created by Nikita on 27.08.22.
//

import SwiftUI

struct AddActorScreen: View {
    let movie: MovieViewModel
    
    @StateObject private var viewModel: AddActorViewModel = AddActorViewModel()
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        
            Form {
                VStack(alignment: .leading) {
                    Text("Add Actor")
                        .font(.largeTitle)
                    Text(movie.title)
                }.padding(.bottom, 50)
                TextField("Enter name", text: $viewModel.name)
                HStack {
                    Spacer()
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }.buttonStyle(PlainButtonStyle())
                    Spacer()
                    Button("Save") {
                        viewModel.addActorToMovieWith(id: movie.id)
                        presentationMode.wrappedValue.dismiss()
                    }.buttonStyle(PlainButtonStyle())
                    Spacer()
                }
            }
    }
}

struct AddActorScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddActorScreen(movie: .init(movie: Movie(context: Movie.viewContext)))
    }
}
