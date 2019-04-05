//
//  MovieDTO.swift
//  PopularMovies
//
//  Created by Andrei Sherstniuk on 4/4/19.
//  Copyright © 2019 Andrei Sherstniuk. All rights reserved.
//

import Foundation

struct MovieDTO: Movie {
    var id: Int
    var posterPath: String?
    var title: String?
    var releaseDate: Date?
    var overview: String?
    var genres: [String]?
    var youTubeKey: String?
}
