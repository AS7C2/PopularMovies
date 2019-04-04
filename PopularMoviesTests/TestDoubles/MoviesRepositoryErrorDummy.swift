//
//  MoviesRepositoryErrorDummy.swift
//  PopularMovies
//
//  Created by Andrei Sherstniuk on 4/4/19.
//  Copyright © 2019 Andrei Sherstniuk. All rights reserved.
//

class MoviesRepositoryErrorDummy: MoviesRepository {
    func add(movies: [Movie], completionHandler: @escaping (Result<Void, Error>) -> Void) {
        completionHandler(.failure(ErrorStub.error))
    }
    
    func getAll(completionHandler: @escaping (Result<[Movie], Error>) -> Void) {
        completionHandler(.failure(ErrorStub.error))
    }
    
    func clear(completionHandler: @escaping (Result<Void, Error>) -> Void) {
        completionHandler(.failure(ErrorStub.error))
    }
}
