//
//  GetMovieDetailsServiceDummy.swift
//  PopularMovies
//
//  Created by Andrei Sherstniuk on 4/4/19.
//  Copyright © 2019 Andrei Sherstniuk. All rights reserved.
//

class GetMovieDetailsServiceFake: GetMovieDetailsService {
    let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    func get(byId id: Int, completionHandler: @escaping (Result<Movie, Error>) -> Void) {
        completionHandler(.success(movie))
    }
}
