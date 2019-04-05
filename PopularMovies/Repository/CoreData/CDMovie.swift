//
//  CDMovie.swift
//  PopularMovies
//
//  Created by Andrei Sherstniuk on 4/5/19.
//  Copyright © 2019 Andrei Sherstniuk. All rights reserved.
//

import CoreData

@objc(CDMovie)
class CDMovie: NSManagedObject {
    @NSManaged public var id: Int32
    @NSManaged public var title: String?
    @NSManaged public var releaseDate: Date?
    @NSManaged public var posterPath: String?
    @NSManaged public var overview: String?
    @NSManaged public var genres: String?
    @NSManaged public var youTubeKey: String?
}

extension CDMovie {
    func fillWith(movie: Movie) {
        id = Int32(movie.id)
        title = movie.title
        releaseDate = movie.releaseDate
        overview = movie.overview
        if let genres = movie.genres {
            self.genres = genres.joined(separator: ",")
        } else {
            self.genres = nil
        }
        self.posterPath = movie.posterPath
        self.youTubeKey = movie.youTubeKey
    }
}

extension MovieDTO {
    static func fromCDMovie(cdMovie: CDMovie) -> MovieDTO {
        return MovieDTO(
            id: Int(cdMovie.id),
            posterPath: cdMovie.posterPath,
            title: cdMovie.title,
            releaseDate: cdMovie.releaseDate,
            overview: cdMovie.overview,
            genres: cdMovie.genres?.split(separator: ",").map {String($0)},
            youTubeKey: cdMovie.youTubeKey)
    }
}
