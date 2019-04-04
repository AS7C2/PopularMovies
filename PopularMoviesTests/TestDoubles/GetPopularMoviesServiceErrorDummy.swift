//
//  GetPopularMoviesServiceErrorStub.swift
//  PopularMovies
//
//  Created by Andrei Sherstniuk on 4/4/19.
//  Copyright © 2019 Andrei Sherstniuk. All rights reserved.
//

class GetPopularMoviesServiceErrorDummy: GetPopularMoviesService {
    func get(completionHandler: @escaping (Result<[Movie], Error>) -> Void) {
        completionHandler(.failure(ErrorStub.error))
    }
}
