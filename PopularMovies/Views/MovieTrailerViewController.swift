//
//  MovieTrailerViewController.swift
//  PopularMovies
//
//  Created by Andrei Sherstniuk on 4/5/19.
//  Copyright © 2019 Andrei Sherstniuk. All rights reserved.
//

import UIKit

class MovieTrailerViewController: UIViewController {
    var presenter: MovieTrailerPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black
        
        presenter.getYouTubeKey()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(done))
    }
    
    @objc func done() {
        presenter.closeTrailer()
    }
}

extension MovieTrailerViewController: MovieTrailerPresenterViewDelegate {
    func movieTrailerPresenter(presenter: MovieTrailerPresenter, didGetYouTubeKey youTubeKey: String) {
        
    }
}
