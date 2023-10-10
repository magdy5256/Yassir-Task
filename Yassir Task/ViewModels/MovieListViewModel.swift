//
//  MovieListViewModel.swift
//  Yassir Task
//
//  Created by Magdy Khaled on 09/10/2023.
//

import Foundation
class MovieListViewModel: ObservableObject {
    
    @Published var movies: [Movie]?
    @Published var isLoading: Bool = false
    @Published var error: NSError?

    private let movieProrocol: MovieDataProtocol
    
    init(movieProtocol: MovieDataProtocol = MovieNetworkLayer.shared) {
        self.movieProrocol = movieProtocol
    }
    
    func getMovies() {
        self.movies = nil
        self.isLoading = true
        self.movieProrocol.getMovies() { [weak self] (result) in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .success(let response):
                self.movies = response.results
                
            case .failure(let error):
                self.error = error as NSError
            }
        }
    }
    
}

