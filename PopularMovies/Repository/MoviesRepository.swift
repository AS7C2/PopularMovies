//
//  MoviesRepository.swift
//  PopularMovies
//
//  Created by Andrei Sherstniuk on 4/4/19.
//  Copyright © 2019 Andrei Sherstniuk. All rights reserved.
//

protocol MoviesRepository {
    func save(movie: Movie)
    
    func clear()
}
