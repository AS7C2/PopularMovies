//
//  MovieTrailerCoordinator.swift
//  PopularMovies
//
//  Created by Andrei Sherstniuk on 4/5/19.
//  Copyright © 2019 Andrei Sherstniuk. All rights reserved.
//

import UIKit

class MovieTrailerCoordinator {
    private let movie: Movie
    private let navigationController: UINavigationController
    private let repository: MoviesRepository
    
    init(movie: Movie, repository: MoviesRepository, navigationController: UINavigationController) {
        self.movie = movie
        self.repository = repository
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = MovieTrailerViewController()
        viewController.title = "Trailer"
        navigationController.pushViewController(viewController, animated: true)
    }
}
