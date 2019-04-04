//
//  PosterURLFactory.swift
//  PopularMovies
//
//  Created by Andrei Sherstniuk on 4/4/19.
//  Copyright © 2019 Andrei Sherstniuk. All rights reserved.
//

import Foundation

protocol PosterURLFactory {
    func create(posterPath: String) -> URL?
}
