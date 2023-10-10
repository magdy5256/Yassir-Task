//
//  MoviesList.swift
//  Yassir Task
//
//  Created by Magdy Khaled on 09/10/2023.
//

import SwiftUI

struct MoviesList: View {
    @ObservedObject private var movieListViewModel = MovieListViewModel()
    
    var body: some View {
        NavigationView {
            List {
                Group {
                    if movieListViewModel.movies != nil {
                        MovieItem( movies: movieListViewModel.movies!)
                        
                    } else {
                        LoaderView(isLoading: self.movieListViewModel.isLoading, error: self.movieListViewModel.error) {
                            self.movieListViewModel.getMovies()
                        }
                    }
                    
                }
                .listRowInsets(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
                
            }
        }
        .onAppear {
            self.movieListViewModel.getMovies()
        }
        
    }
}
