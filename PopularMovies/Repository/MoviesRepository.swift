//
//  MoviesRepository.swift
//  PopularMovies
//
//  Created by Andrei Sherstniuk on 4/4/19.
//  Copyright © 2019 Andrei Sherstniuk. All rights reserved.
//

protocol MoviesRepository {
    func add(movies: [Movie], completionHandler: @escaping (Result<Void, Error>) -> Void)
    
    func getAll(completionHandler: @escaping (Result<[Movie], Error>) -> Void)
    
    func clear(completionHandler: @escaping (Result<Void, Error>) -> Void)
    
    func update(movie: Movie, completionHandler: @escaping (Result<Void, Error>) -> Void)
    
    func get(byId id: Int, completionHandler: @escaping (Result<Movie, Error>) -> Void)
}
