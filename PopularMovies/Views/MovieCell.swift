//
//  MovieCell.swift
//  PopularMovies
//
//  Created by Andrei Sherstniuk on 4/4/19.
//  Copyright © 2019 Andrei Sherstniuk. All rights reserved.
//

import UIKit
import SDWebImage

class MovieCell: UITableViewCell {
    var model: MovieDisplayModel! {
        didSet {
            movieTitleLabel.text = model.title
        }
    }
    
    @IBOutlet weak var moviePosterImageView: UIImageView!
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    override func prepareForReuse() {
        moviePosterImageView.sd_cancelCurrentImageLoad()
    }
    
    func showPoster() {
        moviePosterImageView.sd_setImage(with: model.posterURL, completed: nil)
    }
}
