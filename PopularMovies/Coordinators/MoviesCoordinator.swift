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
    private var navigationController: UINavigationController?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let service = TMDBGetPopularMoviesService(configuration: TMDBConfiguration())
        let repository = InMemoryMoviesRepository()
        let interactor = GetPopularMoviesInteractor(service: service, repository: repository)
        let movieDisplayModelFactory = DefaultMovieDisplayModelFactory(posterURLFactory: SmallPosterURLFactory())
        let presenter = DefaultMoviesPresenter(getMoviesInteractor: interactor, movieDisplayModelFactory: movieDisplayModelFactory)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "MOVIES") as! MoviesViewController
        viewController.presenter = presenter
        presenter.viewDelegate = viewController
        presenter.coordinatorDelegate = self
        
        navigationController =  UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
    }
}

extension MoviesCoordinator: MoviesPresenterCoordinatorDelegate {
    func moviesPresenter(presenter: MoviesPresenter, didSelectMovie movie: Movie) {
        let movieDetailsCoordinator = MovieDetailsCoordinator(movie: movie, navigationController: navigationController!)
        movieDetailsCoordinator.start()
    }
}
