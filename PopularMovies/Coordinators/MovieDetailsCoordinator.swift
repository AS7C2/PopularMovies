//
//  MovieDetailsCoordinator.swift
//  PopularMovies
//
//  Created by Andrei Sherstniuk on 4/4/19.
//  Copyright © 2019 Andrei Sherstniuk. All rights reserved.
//

import UIKit

class MovieDetailsCoordinator {
    private let movie: Movie
    private let navigationController: UINavigationController
    private let repository: MoviesRepository
    
    private var movieTrailerCoordinator: MovieTrailerCoordinator?
    
    init(movie: Movie, repository: MoviesRepository, navigationController: UINavigationController) {
        self.movie = movie
        self.repository = repository
        self.navigationController = navigationController
    }
    
    func start() {
        let service = TMDBGetMovieDetailsService(configuration: TMDBConfiguration())
        let interactor = DefaultGetMovieDetailsInteractor(service: service, repository: repository)
        let movieDisplayModelFactory = DefaultMovieDisplayModelFactory(posterURLFactory: BigPosterURLFactory())
        let presenter = DefaultMovieDetailsPresenter(
            movie: movie,
            getMovieDetailsInteractor: interactor,
            movieDisplayModelFactory: movieDisplayModelFactory)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "MOVIE_DETAILS") as! MovieDetailsViewController
        viewController.presenter = presenter
        viewController.title = "Movie Detail"
        presenter.viewDelegate = viewController
        presenter.coordinatorDelegate = self
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension MovieDetailsCoordinator: MovieDetailsPresenterCoordinatorDelegate {
    func movieDetailsPresenterDidSelectWatchTrailer(presenter: MovieDetailsPresenter) {
        movieTrailerCoordinator = MovieTrailerCoordinator(
            movie: movie,
            repository: repository,
            navigationController: navigationController)
        movieTrailerCoordinator?.start()
    }
}
