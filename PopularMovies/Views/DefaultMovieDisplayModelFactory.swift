//
//  DefaultMovieDisplayModelFactory.swift
//  PopularMovies
//
//  Created by Andrei Sherstniuk on 4/4/19.
//  Copyright © 2019 Andrei Sherstniuk. All rights reserved.
//

import Foundation

class DefaultMovieDisplayModelFactory: MovieDisplayModelFactory {
    func create(fromMovie movie: Movie) -> MovieDisplayModel {
        return MovieDisplayModel(posterURL: getPosterURL(posterPath: movie.posterPath), title: movie.title)
    }
    
    private func getPosterURL(posterPath: String?) -> URL? {
        guard let posterPath = posterPath else {
            return nil
        }
        return URL(string: "https://image.tmdb.org/t/p/w300\(posterPath)")
    }
}
