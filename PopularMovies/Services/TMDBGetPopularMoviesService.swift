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
    private let configuration: TMDBConfiguration
    
    init(configuration: TMDBConfiguration) {
        self.configuration = configuration
    }
    
    func get(completionHandler: @escaping (Swift.Result<[Movie], Error>) -> Void) {
        Alamofire
            .request("https://api.themoviedb.org/3/movie/popular?api_key=\(configuration.apiKey)")
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
                                    if let movie = MovieDTO.fromTMDBJSON(json: result) {
                                        movies.append(movie)
                                    }
                                }
                                completionHandler(.success(movies))
                            } else {
                                completionHandler(.failure(TMDBServiceError.unexpectedData))
                            }
                        } catch let error {
                            completionHandler(.failure(error))
                        }
                    } else {
                        completionHandler(.failure(TMDBServiceError.unexpectedData))
                    }
                    break;
                case .failure(let error):
                    completionHandler(.failure(error))
                }
            }
    }
}
