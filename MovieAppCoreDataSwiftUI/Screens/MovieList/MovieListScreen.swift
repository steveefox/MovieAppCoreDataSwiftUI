//
//  MovieListScreen.swift
//  MovieAppCoreDataSwiftUI
//
//  Created by Nikita on 23.08.22.
//

import SwiftUI

enum Sheets: Identifiable {
    
    var id: UUID {
        return UUID()
    }
    
    case addMovie
    case showFilters
}

struct MovieListScreen: View {
    @StateObject private var viewModel: MovieListViewModel = MovieListViewModel()
    
    @State private var isPresented: Bool = false
    @State private var activeSheet: Sheets?
    @State private var filterApplied: Bool = false
    
    
    private func deleteMovie(at indexSet: IndexSet) {
        indexSet.forEach { index in
            let movie = viewModel.movies[index]
            
            viewModel.deleteMovie(movie)
            viewModel.getAllMovies()
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Button("Reset") {
                    viewModel.getAllMovies()
                }.padding()
                Button("Sort") {
                    viewModel.sortEnabled = true
                }
                Spacer()
                Button("Filter") {
                    filterApplied = true
                    activeSheet = .showFilters
                }
            }.padding(.trailing, 40)
            
            List {
                
                ForEach(viewModel.movies, id: \.id) { movie in
                    NavigationLink(
                        destination: MovieDetailScreen(movie: movie),
                        label: {
                            MovieCell(movie: movie)
                        })
                }.onDelete(perform: deleteMovie)
                
            }.listStyle(PlainListStyle())
            
            .navigationTitle("Movies")
            .navigationBarItems(trailing: Button("Add Movie") {
                activeSheet = .addMovie
            })
            .sheet(item: $activeSheet, onDismiss: {
                
            }, content: { item in
                switch item {
                    case .addMovie:
                        AddMovieScreen()
                    case .showFilters:
                    ShowFiltersScreen(movies: $viewModel.movies)
                }
            })
            .onAppear(perform: {
                UITableView.appearance().separatorStyle = .none
                UITableView.appearance().separatorColor = .clear
                viewModel.getAllMovies()
        })
            if viewModel.sortEnabled {
                GeometryReader { geometry in
                    VStack {
                        HStack {
                            Spacer()
                            Picker("Select title", selection: $viewModel.selectedSortOption) {
                                ForEach(SortOptions.allCases, id: \.self) {
                                    Text($0.displayText)
                                }
                            }.frame(width: geometry.size.width/3, height: 100)
                                .clipped()
                            
                            Picker("Sort Direction", selection: $viewModel.selectedSortDirection) {
                                ForEach(SortDirection.allCases, id: \.self) {
                                    Text($0.displayText)
                                }
                            }.frame(width: geometry.size.width/3, height: 100)
                                .clipped()
                            
                            Spacer()
                        }
                        Button("Done") {
                            viewModel.sortEnabled = false
                            viewModel.sort()
                        }
                    }
                }
            }
            
        }.embedInNavigationView()
    }
}

struct MovieListScreen_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MovieListScreen()
        }
    }
}

struct MovieCell: View {
    
    let movie: MovieViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(movie.title)
                    .fontWeight(.bold)
                    .font(.system(size: 22))
                Text(movie.director)
                    .font(.callout)
                    .opacity(0.5)
                Text(movie.releaseDate ?? "")
                    .font(.callout)
                    .opacity(0.8)
                Spacer()
                
            }
            Spacer()
            HStack {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                Text("\(movie.rating!)")
            }
        }
        .padding()
        .foregroundColor(Color.black)
        .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9567790627, green: 0.9569163918, blue: 0.9567491412, alpha: 1)), Color(#colorLiteral(red: 0.9685427547, green: 0.9686816335, blue: 0.9685124755, alpha: 1))]), startPoint: .leading, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/))
        .clipShape(RoundedRectangle(cornerRadius: 15.0, style: .continuous))
    }
}
