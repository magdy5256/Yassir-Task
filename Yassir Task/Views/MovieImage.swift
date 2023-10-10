//
//  MovieImage.swift
//  Yassir Task
//
//  Created by Magdy Khaled on 09/10/2023.
//


import SwiftUI

struct MovieImage: View {
    
    let movie: Movie
    @ObservedObject var imageLoader = ImageLoader()
    
    var body: some View {
        HStack {
            if self.imageLoader.image != nil {
                Image(uiImage: self.imageLoader.image!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(8)
                    .shadow(radius: 4)
                Text(movie.title)
                    .multilineTextAlignment(.center)
            }
        }
        .frame(height: 100)
        .padding()
        .onAppear {
            self.imageLoader.loadImage(with: self.movie.posterURL)
        }
    }
}
