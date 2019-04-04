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
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let service = TMDBGetPopularMoviesService()
        let repository = InMemoryMoviesRepository()
        let interactor = GetPopularMoviesInteractor(service: service, repository: repository)
        let movieDisplayModelFactory = DefaultMovieDisplayModelFactory()
        let presenter = DefaultMoviesPresenter(getMoviesInteractor: interactor, movieDisplayModelFactory: movieDisplayModelFactory)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "MOVIES") as! MoviesViewController
        viewController.presenter = presenter
        presenter.viewDelegate = viewController
        
        let navigationController =  UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
    }
}
