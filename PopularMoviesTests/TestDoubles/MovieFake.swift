//
//  MovieFake.swift
//  PopularMoviesTests
//
//  Created by Andrei Sherstniuk on 4/4/19.
//  Copyright © 2019 Andrei Sherstniuk. All rights reserved.
//

class MovieFake: Movie {
    var id: Int
    
    var posterPath: String?
    
    var title: String?
    
    init(id: Int) {
        self.id = id
    }
}
