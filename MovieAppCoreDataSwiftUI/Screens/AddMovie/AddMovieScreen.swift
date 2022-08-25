//
//  AddMovieScreen.swift
//  MovieAppCoreDataSwiftUI
//
//  Created by Nikita on 23.08.22.
//

import SwiftUI

struct AddMovieScreen: View {
    @StateObject private var viewModel: AddMovieViewModel = AddMovieViewModel()
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Form {
            TextField("Enter name", text: $viewModel.title)
            TextField("Enter director", text: $viewModel.director)
            HStack {
                Text("Rating")
                Spacer()
                RatingView(rating: $viewModel.rating)
            }
            DatePicker("Release Date", selection: $viewModel.releaseDate)
            
            HStack {
                Spacer()
                Button("Save") {
                    viewModel.save()
                    presentationMode.wrappedValue.dismiss()
                }
                Spacer()
            }
            
        }
        .navigationTitle("Add Movie")
        .embedInNavigationView()
    }
}

struct AddMovieScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddMovieScreen()
    }
}
