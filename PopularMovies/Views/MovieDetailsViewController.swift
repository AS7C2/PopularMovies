//
//  MovieDetailsViewController.swift
//  PopularMovies
//
//  Created by Andrei Sherstniuk on 4/4/19.
//  Copyright © 2019 Andrei Sherstniuk. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    var presenter: MovieDetailsPresenter!
    var movie: MovieDisplayModel! {
        didSet {
            moviePosterImageView.sd_setImage(with: movie.posterURL, completed: nil)
            movieTitleLabel.text = movie.title
            // TODO: add other fields
        }
    }
    
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieGenresLabel: UILabel!
    @IBOutlet weak var movieDateLabel: UILabel!
    @IBOutlet weak var movieOverviewLabel: UILabel!
    
    @IBAction func onWatchTrailerClicked(_ sender: UIButton) {
    }
}

extension MovieDetailsViewController: MovieDetailsPresenterViewDelegate {
    func movieDetailsPresenter(presenter: MovieDetailsPresenter, didGetMovieDetails movie: MovieDisplayModel) {
        self.movie = movie
    }
}
