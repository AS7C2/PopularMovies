//
//  InMemoryMoviesRepsitory.swift
//  PopularMovies
//
//  Created by Andrei Sherstniuk on 4/4/19.
//  Copyright © 2019 Andrei Sherstniuk. All rights reserved.
//

class InMemoryMoviesRepository: MoviesRepository {
    private var movies: [Movie] = []
    
    func update(movie: Movie, completionHandler: @escaping (Result<Void, Error>) -> Void) {
        var i = 0
        while i < movies.count && movies[i].id != movie.id {
            i += 1
        }
        if i < movies.count {
            movies[i] = movie
            completionHandler(.success(()))
        } else {
            completionHandler(.failure(MoviesRepositoryError.movieNotFound))
        }
    }
    
    func get(byId id: Int, completionHandler: @escaping (Result<Movie, Error>) -> Void) {
        if let movie = (movies.filter { $0.id == id }.first) {
            completionHandler(.success(movie))
        } else {
            completionHandler(.failure(MoviesRepositoryError.movieNotFound))
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
