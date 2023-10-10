//
//  MovieItem.swift
//  Yassir Task
//
//  Created by Magdy Khaled on 09/10/2023.
//

import SwiftUI

struct MovieItem: View {
    let movies: [Movie]
    var body: some View {

            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 16) {
                    ForEach(self.movies) { movie in
                        NavigationLink(destination: MovieDetails(movie: movie)) {
                            MovieImage(movie: movie)
                        }
                        .buttonStyle(PlainButtonStyle())
                            .padding(.leading, movie.id == self.movies.first!.id ? 16 : 0)
                            .padding(.trailing, movie.id == self.movies.last!.id ? 16 : 0)
                    }
                }
            }
        }
        
    }


