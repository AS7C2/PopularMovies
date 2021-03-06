//
//  MoviesCoordinator.swift
//  PopularMovies
//
//  Created by Andrei Sherstniuk on 4/4/19.
//  Copyright © 2019 Andrei Sherstniuk. All rights reserved.
//

import UIKit

class MoviesCoordinator {
    private let window: UIWindow
    private var navigationController: UINavigationController!
    private var repository: MoviesRepository!
    
    private var movieDetailsCoordinator: MovieDetailsCoordinator!
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let service = TMDBGetPopularMoviesService(configuration: TMDBConfiguration())
        repository = CoreDataMoviesRepository()
        let interactor = GetPopularMoviesInteractor(service: service, repository: repository)
        let movieDisplayModelFactory = DefaultMovieDisplayModelFactory(posterURLFactory: SmallPosterURLFactory())
        let presenter = DefaultMoviesPresenter(getMoviesInteractor: interactor, movieDisplayModelFactory: movieDisplayModelFactory)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "MOVIES") as! MoviesViewController
        viewController.presenter = presenter
        presenter.viewDelegate = viewController
        presenter.coordinatorDelegate = self
        viewController.title = "Movie Catalog"
        navigationController =  UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
    }
}

extension MoviesCoordinator: MoviesPresenterCoordinatorDelegate {
    func moviesPresenter(presenter: MoviesPresenter, didSelectMovie movie: Movie) {
        movieDetailsCoordinator = MovieDetailsCoordinator(
            movie: movie,
            repository: repository,
            navigationController: navigationController)
        movieDetailsCoordinator.start()
    }
}
