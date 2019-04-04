//
//  MoviesRepositorySpy.swift
//  PopularMovies
//
//  Created by Andrei Sherstniuk on 4/4/19.
//  Copyright © 2019 Andrei Sherstniuk. All rights reserved.
//

class MoviesRepositorySpy: MoviesRepository {
    var movies: [Movie] = []
    
    var count: Int {
        get {
            return movies.count
        }
    }
    
    func save(movie: Movie) {
        movies.append(movie)
    }
    
    func clear() {
        movies.removeAll()
    }
}
