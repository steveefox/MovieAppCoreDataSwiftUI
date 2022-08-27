//
//  ReviewListScreen.swift
//  MovieAppCoreDataSwiftUI
//
//  Created by Nikita on 24.08.22.
//

import Foundation
import SwiftUI

struct ReviewListScreen: View {
    
    let movie: MovieViewModel
    @State private var isPresented: Bool = false
    @StateObject private var viewModel: ReviewListViewModel = ReviewListViewModel()
    
    
    var body: some View {
        VStack {
            List {
                Section(header: Text("Reviews")) {
                    ForEach(viewModel.reviews, id: \.reviewId) { review in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(review.title)
                                Text(review.text)
                                    .font(.caption)
                            }
                            Spacer()
                            if let date = review.publishedDate {
                                Text(DateFormatterHelper.formattedString(from: date))
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle(movie.title)
        .navigationBarItems(trailing: Button("Add New Review") {
             isPresented = true
        })
        .sheet(isPresented: $isPresented, onDismiss: {
            viewModel.getReviewsFor(movie: movie)
        }, content: {
            AddReviewScreen(movie: movie)
        })
        .onAppear(perform: {
            viewModel.getReviewsFor(movie: movie)
        })
    }
}

struct ReviewListScreen_Previews: PreviewProvider {
    static var previews: some View {
        let movie = MovieViewModel(movie: Movie(context: CoreDataStack.shared.viewContext))
        ReviewListScreen(movie: movie).embedInNavigationView()
    }
}
