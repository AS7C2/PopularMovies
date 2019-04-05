//
//  MovieTrailerCoordinator.swift
//  PopularMovies
//
//  Created by Andrei Sherstniuk on 4/5/19.
//  Copyright © 2019 Andrei Sherstniuk. All rights reserved.
//

import UIKit

class MovieTrailerCoordinator {
    private let youTubeKey: String
    private let navigationController: UINavigationController
    private let repository: MoviesRepository
    
    init(youTubeKey: String, repository: MoviesRepository, navigationController: UINavigationController) {
        self.youTubeKey = youTubeKey
        self.repository = repository
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = MovieTrailerViewController()
        let presenter = DefaultMovieTrailerPresenter(youTubeKey: youTubeKey)
        viewController.presenter = presenter
        presenter.viewDelegate = viewController
        presenter.coordinatorDelegate = self
        viewController.title = "Trailer"
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension MovieTrailerCoordinator: MovieTrailerPresenterCoordinatorDelegate {
    func movieTrailerPresenterDidSelectClose(presenter: MovieTrailerPresenter) {
        navigationController.popViewController(animated: true)
    }
}
