//
//  GetPopularMoviesService.swift
//  PopularMovies
//
//  Created by Andrei Sherstniuk on 4/4/19.
//  Copyright © 2019 Andrei Sherstniuk. All rights reserved.
//

protocol GetPopularMoviesService {
    func execute(completionHandler: @escaping (Result<[Movie], Error>) -> Void)
}
