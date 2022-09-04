//
//  ShowFiltersScreen.swift
//  MovieAppCoreDataSwiftUI
//
//  Created by Nikita on 30.08.22.
//

import SwiftUI

struct ShowFiltersScreen: View {
    @StateObject private var viewModel: FiltersViewModel = FiltersViewModel()
    
    @State private var releaseDate: String = ""
    @State private var startDate: String = ""
    @State private var endDate: String = ""
    @State private var minimumRating: String = ""
    @State private var movieTitle: String = ""
    @State private var actorName: String = ""
    @State private var minimumReviewCount: String = "1"
    
    @Binding var movies: [MovieViewModel]
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Form {
            
            Section(header: Text("Search by release date")) {
                TextField("Enter release date", text: $releaseDate)
                HStack {
                    Spacer()
                    Button("Search") {
                        
                        guard let releaseData = DateFormatterHelper.dateFrom(string: releaseDate)
                        else { return }
                        
                        movies = viewModel.filterMovieBy(releaseDate: releaseData)
                        presentationMode.wrappedValue.dismiss()
                        
                    }.buttonStyle(PlainButtonStyle())
                    Spacer()
                }
            }
            
            Section(header: Text("Search by date range")) {
                TextField("Enter start date", text: $startDate)
                TextField("Enter end date", text: $endDate)
                HStack {
                    Spacer()
                    Button("Search") {
                        guard let lowerBoundDate = DateFormatterHelper.dateFrom(string: startDate),
                              let upperBoundDate = DateFormatterHelper.dateFrom(string: endDate)
                        else { return }
                        
                        movies = viewModel.filterMovieByReleaseDateRange(lowerBoundDate: lowerBoundDate,
                                                                         upperBoundDate: upperBoundDate)
                        presentationMode.wrappedValue.dismiss()
                       
                    }.buttonStyle(PlainButtonStyle())
                    Spacer()
                }
            }
            
            Section(header: Text("Search by date range or rating")) {
                TextField("Enter start date", text: $startDate)
                TextField("Enter end date", text: $endDate)
                TextField("Enter minimum rating", text: $minimumRating)
                HStack {
                    Spacer()
                    Button("Search") {
                        let lowerBoundDate = DateFormatterHelper.dateFrom(string: startDate)
                        let upperBoundDate = DateFormatterHelper.dateFrom(string: endDate)
                        let minRating = Int(minimumRating)
                        
                        movies = viewModel.filterMoviesBy(lowerDate: lowerBoundDate,
                                                          upperDate: upperBoundDate,
                                                          orMinimumRating: minRating)
                        
                        presentationMode.wrappedValue.dismiss()
                       
                    }.buttonStyle(PlainButtonStyle())
                    Spacer()
                }
            }
            
            Section(header: Text("Search by movie title begins with")) {
                TextField("Enter movie title", text: $movieTitle)
                HStack {
                    Spacer()
                    Button("Search") {
                        
                        movies = viewModel.filterMoviesBy(title: movieTitle)
                        presentationMode.wrappedValue.dismiss()
                        
                    }.buttonStyle(PlainButtonStyle())
                    Spacer()
                }
            }
            
            Section(header: Text("Search by actor name")) {
                TextField("Enter actor name", text: $actorName)
                HStack {
                    Spacer()
                    Button("Search") {
                        
                        movies = viewModel.filerMoviesBy(actorName: actorName)
                        presentationMode.wrappedValue.dismiss()
                        
                    }.buttonStyle(PlainButtonStyle())
                    Spacer()
                }
            }
            
            Section(header: Text("Search by minimum review count")) {
                TextField("Enter minimum review count", text: $minimumReviewCount)
                HStack {
                    Spacer()
                    Button("Search") {
                        
                        guard let minReviewCount = Int(minimumReviewCount) else { return }
                        
                        movies = viewModel.filterBy(minimumReviewCount: minReviewCount)
                        presentationMode.wrappedValue.dismiss()
                        
                    }.buttonStyle(.plain)
                    Spacer()
                }
            }
            
        }
        .navigationTitle("Filters")
        .embedInNavigationView()
    }
}

struct ShowFiltersScreen_Previews: PreviewProvider {
    static var previews: some View {
        ShowFiltersScreen(movies: .constant([MovieViewModel(movie: Movie())]))
    }
}
