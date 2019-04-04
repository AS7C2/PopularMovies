//
//  MoviesPresenter.swift
//  PopularMovies
//
//  Created by Andrei Sherstniuk on 4/4/19.
//  Copyright © 2019 Andrei Sherstniuk. All rights reserved.
//

class DefaultMoviesPresenter: MoviesPresenter {
    weak var viewDelegate: MoviesPresenterViewDelegate?
    
    private let getMoviesInteractor: GetMoviesInteractor
    private let movieDisplayModelFactory: MovieDisplayModelFactory
    private var originalMovies: [Movie] = []
    private var currentMovies: [Movie] = []
    
    init(getMoviesInteractor: GetMoviesInteractor, movieDisplayModelFactory: MovieDisplayModelFactory) {
        self.getMoviesInteractor = getMoviesInteractor
        self.movieDisplayModelFactory = movieDisplayModelFactory
    }
    
    func getMovies() {
        getMoviesInteractor.get() { result in
            switch result {
            case .success(let movies):
                self.originalMovies.removeAll()
                self.currentMovies.removeAll()
                self.originalMovies.append(contentsOf: movies)
                self.currentMovies.append(contentsOf: movies)
                if let viewDelegate = self.viewDelegate {
                    viewDelegate.moviesPresenterDidGetMovies(presenter: self)
                }
            default:
                break
            }
        }
    }
    
    func searchMovies(searchText: String) {
        self.currentMovies.removeAll()
        if (searchText.isEmpty) {
            self.currentMovies.append(contentsOf: originalMovies)
        } else {
            let searchedMovies = self.originalMovies.filter { movie in
                if let title = movie.title {
                    return title.lowercased().contains(searchText.lowercased())
                } else {
                    return false
                }
            }
            self.currentMovies.append(contentsOf: searchedMovies)
        }
        if let viewDelegate = self.viewDelegate {
            viewDelegate.moviesPresenterDidGetMovies(presenter: self)
        }
    }
    
    var numberOfMovies: Int {
        get {
            return currentMovies.count
        }
    }
    
    func movie(atIndex index: Int) -> MovieDisplayModel {
        return movieDisplayModelFactory.create(fromMovie: currentMovies[index])
    }
    
    func selectMovie(atIndex index: Int) {
        let movie = currentMovies[index]
    }
}
