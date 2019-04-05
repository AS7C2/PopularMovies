//
//  Movie.swift
//  PopularMovies
//
//  Created by Andrei Sherstniuk on 4/4/19.
//  Copyright © 2019 Andrei Sherstniuk. All rights reserved.
//

import Foundation

protocol Movie {
    var id: Int { get }
    var posterPath: String? { get }
    var title: String? { get }
    var releaseDate: Date? { get }
    var overview: String? { get }
    var genres: [String]? { get }
    var youTubeKey: String? { get }
}
