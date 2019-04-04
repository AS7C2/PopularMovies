//
//  MoviesPresenter.swift
//  PopularMovies
//
//  Created by Andrei Sherstniuk on 4/4/19.
//  Copyright © 2019 Andrei Sherstniuk. All rights reserved.
//

protocol MoviesPresenterViewDelegate: class {
    func moviesPresenterDidGetMovies(presenter: MoviesPresenter)
}

protocol MoviesPresenterCoordinatorDelegate: class {
    func moviesPresenter(presenter: MoviesPresenter, didSelectMovie movie: Movie)
}

protocol MoviesPresenter {
    var viewDelegate: MoviesPresenterViewDelegate? { get set }
    var coordinatorDelegate: MoviesPresenterCoordinatorDelegate? { get set }
    
    func getMovies()
    
    func searchMovies(searchText: String)
    
    var numberOfMovies: Int { get }
    
    func movie(atIndex index: Int) -> MovieDisplayModel
    
    func selectMovie(atIndex index: Int)
}
