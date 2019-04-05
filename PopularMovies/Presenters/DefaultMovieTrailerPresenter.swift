//
//  DefaultMovieTrailerPresenter.swift
//  PopularMovies
//
//  Created by Andrei Sherstniuk on 4/5/19.
//  Copyright © 2019 Andrei Sherstniuk. All rights reserved.
//

class DefaultMovieTrailerPresenter: MovieTrailerPresenter {
    weak var viewDelegate: MovieTrailerPresenterViewDelegate?
    weak var coordinatorDelegate: MovieTrailerPresenterCoordinatorDelegate?
    
    private let youTubeKey: String

    init(youTubeKey: String) {
        self.youTubeKey = youTubeKey
    }
    
    func getYouTubeKey() {
        if let viewDelegate = viewDelegate {
            viewDelegate.movieTrailerPresenter(presenter: self, didGetYouTubeKey: youTubeKey)
        }
    }
    
    func closeTrailer() {
        if let coordinatorDelegate = coordinatorDelegate {
            coordinatorDelegate.movieTrailerPresenterDidSelectClose(presenter: self)
        }
    }
}
