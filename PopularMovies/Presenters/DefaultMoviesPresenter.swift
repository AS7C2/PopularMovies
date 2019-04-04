//
//  MoviesPresenter.swift
//  PopularMovies
//
//  Created by Andrei Sherstniuk on 4/4/19.
//  Copyright © 2019 Andrei Sherstniuk. All rights reserved.
//

class DefaultMoviesPresenter: MoviesPresenter {
    weak var delegate: MoviesPresenterDelegate?
    
    private let getMoviesInteractor: GetMoviesInteractor
    private let movieDisplayModelFactory: MovieDisplayModelFactory
    private var movies: [Movie] = []
    
    init(getMoviesInteractor: GetMoviesInteractor, movieDisplayModelFactory: MovieDisplayModelFactory) {
        self.getMoviesInteractor = getMoviesInteractor
        self.movieDisplayModelFactory = movieDisplayModelFactory
    }
    
    func getMovies() {
        getMoviesInteractor.get() { result in
            switch result {
            case .success(let movies):
                self.movies.removeAll()
                self.movies.append(contentsOf: movies)
                if let delegate = self.delegate {
                    delegate.moviesPresenterDidGetMovies(presenter: self)
                }
            default:
                break
            }
        }
    }
    
    var numberOfMovies: Int {
        get {
            return movies.count
        }
    }
    
    func movie(atIndex index: Int) -> MovieDisplayModel {
        return movieDisplayModelFactory.create(fromMovie: movies[index])
    }
}
