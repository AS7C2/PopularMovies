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
    private var movies: [Movie] = []
    
    init(getMoviesInteractor: GetMoviesInteractor) {
        self.getMoviesInteractor = getMoviesInteractor
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
    
    func movie(atIndex index: Int) -> Movie {
        return movies[index]
    }
}
