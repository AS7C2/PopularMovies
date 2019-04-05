//
//  MovieFake.swift
//  PopularMoviesTests
//
//  Created by Andrei Sherstniuk on 4/4/19.
//  Copyright © 2019 Andrei Sherstniuk. All rights reserved.
//

import Foundation

class MovieFake: Movie {
    var youTubeKey: String?
    var genres: [String]?
    var releaseDate: Date?
    var overview: String?
    var id: Int
    var posterPath: String?
    var title: String?

    init(id: Int) {
        self.id = id
    }
}
