//
//  MovieDetailsPresenter.swift
//  PopularMovies
//
//  Created by Andrei Sherstniuk on 4/4/19.
//  Copyright © 2019 Andrei Sherstniuk. All rights reserved.
//

protocol MovieDetailsPresenterViewDelegate: class {
    func movieDetailsPresenter(presenter: MovieDetailsPresenter, didGetMovieDetails movie: MovieDisplayModel)
    
    func movieDetailsPresenter(presenter: MovieDetailsPresenter, isAbleToWatchTrailer: Bool)
}

protocol MovieDetailsPresenterCoordinatorDelegate: class {
    func movieDetailsPresenterDidSelectWatchTrailer(presenter: MovieDetailsPresenter, withYouTubeKey youTubeKey: String)
}

protocol MovieDetailsPresenter {
    var viewDelegate: MovieDetailsPresenterViewDelegate? { get set }
    var coordinatorDelegate: MovieDetailsPresenterCoordinatorDelegate? { get set }
    
    func getMovieDetails()
    
    func watchTrailer()
}

