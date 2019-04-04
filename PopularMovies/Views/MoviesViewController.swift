//
//  MoviesViewController.swift
//  PopularMovies
//
//  Created by Andrei Sherstniuk on 4/4/19.
//  Copyright © 2019 Andrei Sherstniuk. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {
    var presenter: MoviesPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.getMovies()
    }
}

extension MoviesViewController: MoviesPresenterDelegate {
    func moviesPresenterDidGetMovies(presenter: MoviesPresenter) {
        
    }
}

extension MoviesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfMovies
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MOVIE_CELL") as! MovieCell
        return cell
    }
}
