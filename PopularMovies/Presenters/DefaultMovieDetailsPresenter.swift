//
//  DefaultMovieDetailsPresenter.swift
//  PopularMovies
//
//  Created by Andrei Sherstniuk on 4/4/19.
//  Copyright © 2019 Andrei Sherstniuk. All rights reserved.
//

class DefaultMovieDetailsPresenter: MovieDetailsPresenter {
    weak var viewDelegate: MovieDetailsPresenterViewDelegate?
    weak var coordinatorDelegate: MovieDetailsPresenterCoordinatorDelegate?
    
    private let getMovieDetailsInteractor: GetMovieDetailsInteractor
    private let movieDisplayModelFactory: MovieDisplayModelFactory
    private var movie: Movie
    
    init(movie: Movie, getMovieDetailsInteractor: GetMovieDetailsInteractor, movieDisplayModelFactory: MovieDisplayModelFactory) {
        self.movie = movie
        self.getMovieDetailsInteractor = getMovieDetailsInteractor
        self.movieDisplayModelFactory = movieDisplayModelFactory
    }
}
