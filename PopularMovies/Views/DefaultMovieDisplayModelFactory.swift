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
        return MovieDisplayModel(
            posterURL: getPosterURL(posterPath: movie.posterPath),
            title: movie.title,
            releaseDate: getDateString(date: movie.releaseDate),
            overview: movie.overview,
            genres: getGenresString(genres: movie.genres))
    }
    
    private func getPosterURL(posterPath: String?) -> URL? {
        guard let posterPath = posterPath else {
            return nil
        }
        return posterURLFactory.create(posterPath: posterPath)
    }
    
    private func getDateString(date: Date?) -> String? {
        guard let date = date else {
            return nil
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        return dateFormatter.string(from: date)
    }
    
    private func getGenresString(genres: [String]?) -> String? {
        guard let genres = genres else {
            return nil
        }
        return genres.joined(separator: ", ")
    }
}
