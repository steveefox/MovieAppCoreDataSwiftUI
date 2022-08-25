//
//  AddReviewScreen.swift
//  MovieAppCoreDataSwiftUI
//
//  Created by Nikita on 24.08.22.
//

import Foundation
import SwiftUI

struct AddReviewScreen: View {
    
    @StateObject private var viewModel = AddReviewViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    let movie: MovieViewModel
    
    var body: some View {
        Form {
            TextField("Enter title", text: $viewModel.title)
            TextEditor(text: $viewModel.text)
            
            HStack {
                Spacer()
                Button("Save") {
                    viewModel.addReviewFor(movie: movie)
                    presentationMode.wrappedValue.dismiss()
                }
                Spacer()
            }

        }
        .navigationTitle("Add Review")
        .embedInNavigationView()
    }
}

struct AddReviewScreen_Previews: PreviewProvider {
    static var previews: some View {
        
        let movieVM = MovieViewModel(movie: Movie(context: CoreDataStack.shared.viewContext))
        
        AddReviewScreen(movie: movieVM)
    }
}
