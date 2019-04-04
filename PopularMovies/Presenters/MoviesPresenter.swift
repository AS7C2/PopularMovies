//
//  MoviesPresenter.swift
//  PopularMovies
//
//  Created by Andrei Sherstniuk on 4/4/19.
//  Copyright © 2019 Andrei Sherstniuk. All rights reserved.
//

protocol MoviesPresenterDelegate: class {
    func moviesPresenterDidGetMovies(presenter: MoviesPresenter)
}

protocol MoviesPresenter {
    var delegate: MoviesPresenterDelegate? { get set }
    
    func getMovies()
    
    var numberOfMovies: Int { get }
    
    func movie(atIndex index: Int) -> Movie
}
