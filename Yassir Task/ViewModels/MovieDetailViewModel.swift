//
//  MovieDetailViewModel.swift
//  Yassir Task
//
//  Created by Magdy Khaled on 09/10/2023.
//

import SwiftUI

class MovieDetailViewModel: ObservableObject {
    
    private let movieProtocol: MovieDataProtocol
    @Published var movie: Movie?
    @Published var isLoading = false
    @Published var error: NSError?
    
    init(movieProtocol: MovieDataProtocol = MovieNetworkLayer.shared) {
        self.movieProtocol = movieProtocol
    }
    
    func getMovie(id: Int) {
        self.movie = nil
        self.isLoading = false
        self.movieProtocol.getMovie(id: id) {[weak self] (result) in
            guard let self = self else { return }
            
            self.isLoading = false
            switch result {
            case .success(let movie):
                self.movie = movie
            case .failure(let error):
                self.error = error as NSError
            }
        }
    }
}
