//
//  GetMovieDetailsServiceErrorDummy.swift
//  PopularMoviesTests
//
//  Created by Andrei Sherstniuk on 4/4/19.
//  Copyright © 2019 Andrei Sherstniuk. All rights reserved.
//

class GetMovieDetailsServiceErrorDummy: GetMovieDetailsService {
    func get(byId id: Int, completionHandler: @escaping (Result<Movie, Error>) -> Void) {
        completionHandler(.failure(ErrorStub.error))
    }
}
