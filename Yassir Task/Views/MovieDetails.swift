//
//  MovieDetails.swift
//  Yassir Task
//
//  Created by Magdy Khaled on 09/10/2023.
//

import SwiftUI

struct MovieDetails: View {
    let movie: Movie
    @ObservedObject private var movieDetailViewModel = MovieDetailViewModel()
    
    init(movie: Movie) {
        self.movie = movie
        self.movieDetailViewModel.getMovie(id: self.movie.id)
    }
    
    var body: some View {
        ZStack {
            
            if movieDetailViewModel.movie != nil {
                MovieDetailListView(movie: self.movieDetailViewModel.movie!)
            }
            
            LoaderView(isLoading: self.movieDetailViewModel.isLoading, error: self.movieDetailViewModel.error) {
                self.movieDetailViewModel.getMovie(id: self.movie.id)
            }
            
        }
    }
    
}

struct MovieDetailListView: View {
    
    let movie: Movie
    
    private let imageLoader = ImageLoader()
    
    var body: some View {
        ScrollView {
            
            VStack(alignment: .leading, spacing: 16) {
                MovieDetailImage(imageLoader: imageLoader, imageURL: self.movie.posterURL)
                Text(movie.title)
                    .font(.largeTitle)
                
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(movie.yearText)
                    }
                }
                .font(.system(size: 12, weight: .bold))
                Divider()
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(movie.overview)
                    }
                }
                .font(.system(size: 12, weight: .regular))
                Divider()
                
            }
            .padding()
        }
    }
}

struct MovieDetailImage: View {
    
    @ObservedObject var imageLoader: ImageLoader
    let imageURL: URL
    
    var body: some View {
        ZStack {
            if self.imageLoader.image != nil {
                Image(uiImage: self.imageLoader.image!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(8)
                    .shadow(radius: 4)
            }
        }
        .onAppear {
            self.imageLoader.loadImage(with: self.imageURL)
        }
    }
}

