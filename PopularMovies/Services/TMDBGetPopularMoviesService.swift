//
//  TMDBGetPopularMoviesService.swift
//  PopularMovies
//
//  Created by Andrei Sherstniuk on 4/4/19.
//  Copyright © 2019 Andrei Sherstniuk. All rights reserved.
//

import Alamofire
import SwiftyJSON

class TMDBGetPopularMoviesService: GetPopularMoviesService {
    func get(completionHandler: @escaping (Swift.Result<[Movie], Error>) -> Void) {
        Alamofire
            .request("https://api.themoviedb.org/3/movie/popular?api_key=c9c241876601ccd0c142c5664fbf3d67")
            .validate()
            .responseData { response in
                switch response.result {
                case .success:
                    if let data = response.result.value {
                        do {
                            let json = try JSON(data: data)
                            let results = json["results"]
                            if let results = results.array {
                                var movies: [Movie] = []
                                for result in results {
                                    if let id = result["id"].int {
                                        let movie = MovieDTO(
                                            id: id,
                                            posterPath: result["poster_path"].string,
                                            title: result["title"].string)
                                        movies.append(movie)
                                    }
                                }
                                completionHandler(.success(movies))
                            } else {
                                completionHandler(.success([])) // TODO: This mignt be considered a failure. Further clarification required.
                            }
                        } catch let error {
                            completionHandler(.failure(error))
                        }
                    } else {
                        completionHandler(.success([])) // TODO: This mignt be considered a failure. Further clarification required.
                    }
                    break;
                case .failure(let error):
                    completionHandler(.failure(error))
                }
            }
    }
}
