//
//  MovieTrailerPresenter.swift
//  PopularMovies
//
//  Created by Andrei Sherstniuk on 4/5/19.
//  Copyright © 2019 Andrei Sherstniuk. All rights reserved.
//

protocol MovieTrailerPresenterViewDelegate: class {
    func movieTrailerPresenter(presenter: MovieTrailerPresenter, didGetYouTubeKey youTubeKey: String)
}

protocol MovieTrailerPresenterCoordinatorDelegate: class {
    func movieTrailerPresenterDidSelectClose(presenter: MovieTrailerPresenter)
}

protocol MovieTrailerPresenter {
    var viewDelegate: MovieTrailerPresenterViewDelegate? { get set }
    var coordinatorDelegate: MovieTrailerPresenterCoordinatorDelegate? { get set }
    
    func getYouTubeKey()
    
    func closeTrailer()
}
