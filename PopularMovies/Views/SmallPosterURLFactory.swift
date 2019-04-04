//
//  SmallPosterURLFactory.swift
//  PopularMovies
//
//  Created by Andrei Sherstniuk on 4/4/19.
//  Copyright © 2019 Andrei Sherstniuk. All rights reserved.
//

import Foundation

class SmallPosterURLFactory: PosterURLFactory {
    func create(posterPath: String) -> URL? {
        return URL(string: "https://image.tmdb.org/t/p/w300\(posterPath)")
    }
}
