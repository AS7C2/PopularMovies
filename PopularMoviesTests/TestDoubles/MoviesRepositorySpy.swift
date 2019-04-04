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
    
    func add(movies: [Movie], completionHandler: @escaping (Result<Void, Error>) -> Void) {
        self.movies.append(contentsOf: movies)
        completionHandler(.success(()))
    }
    
    func getAll(completionHandler: @escaping (Result<[Movie], Error>) -> Void) {
        completionHandler(.success(movies))
    }
    
    func clear(completionHandler: @escaping (Result<Void, Error>) -> Void) {
        self.movies.removeAll()
        completionHandler(.success(()))
    }
}
