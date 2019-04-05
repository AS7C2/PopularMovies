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
    
    func getMovieDetails() {
        notifyDidGetMovieDetails(movie: movie)
        getMovieDetailsInteractor.get(byId: movie.id) { result in
            switch (result) {
            case .success(let movie):
                self.movie = movie
                self.notifyDidGetMovieDetails(movie: movie)
                break
            default:
                break
            }
        }
    }
    
    private func notifyDidGetMovieDetails(movie: Movie) {
        if let viewDelegate = self.viewDelegate {
            viewDelegate.movieDetailsPresenter(
                presenter: self,
                didGetMovieDetails: self.movieDisplayModelFactory.create(fromMovie: movie))
            viewDelegate.movieDetailsPresenter(
                presenter: self,
                isAbleToWatchTrailer: movie.youTubeKey != nil)
        }
    }
    
    func watchTrailer() {
        if let coordinatorDelegate = coordinatorDelegate {
            coordinatorDelegate.movieDetailsPresenterDidSelectWatchTrailer(presenter: self)
        }
    }
}
