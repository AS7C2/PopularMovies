//
//  GetMovieDetailsInteractor.swift
//  PopularMovies
//
//  Created by Andrei Sherstniuk on 4/4/19.
//  Copyright © 2019 Andrei Sherstniuk. All rights reserved.
//

protocol GetMovieDetailsInteractor {
    func get(byId id: Int, completionHandler: @escaping (Result<Movie, Error>) -> Void)
}
