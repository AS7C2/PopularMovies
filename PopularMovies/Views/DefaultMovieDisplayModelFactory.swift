//
//  DefaultMovieDisplayModelFactory.swift
//  PopularMovies
//
//  Created by Andrei Sherstniuk on 4/4/19.
//  Copyright © 2019 Andrei Sherstniuk. All rights reserved.
//

import Foundation

class DefaultMovieDisplayModelFactory: MovieDisplayModelFactory {
    let posterURLFactory: PosterURLFactory
    
    init(posterURLFactory: PosterURLFactory) {
        self.posterURLFactory = posterURLFactory
    }
    
    func create(fromMovie movie: Movie) -> MovieDisplayModel {
        return MovieDisplayModel(posterURL: getPosterURL(posterPath: movie.posterPath), title: movie.title)
    }
    
    private func getPosterURL(posterPath: String?) -> URL? {
        guard let posterPath = posterPath else {
            return nil
        }
        return posterURLFactory.create(posterPath: posterPath)
    }
}
