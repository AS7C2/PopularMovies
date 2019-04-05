//
//  MovieDTO+TMDB.swift
//  PopularMovies
//
//  Created by Andrei Sherstniuk on 4/4/19.
//  Copyright © 2019 Andrei Sherstniuk. All rights reserved.
//

import SwiftyJSON

extension MovieDTO {
    static func fromTMDBJSON(json: JSON) -> MovieDTO? {
        if let id = json["id"].int {
            return MovieDTO(
                id: id,
                posterPath: json["poster_path"].string,
                title: json["title"].string,
                releaseDate: parseDate(string: json["release_date"].string),
                overview: json["overview"].string,
                genres: getGenres(json: json),
                youTubeKey: nil)
        } else {
            return nil
        }
    }
    
    private static func parseDate(string: String?) -> Date? {
        guard let string = string else {
            return nil
        }
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: string)
    }
    
    private static func getGenres(json: JSON) -> [String]? {
        guard let genres = json["genres"].array else {
            return nil
        }
        var result: [String] = []
        for genre in genres {
            if let name = genre["name"].string {
                result.append(name)
            }
        }
        return result
    }
}
