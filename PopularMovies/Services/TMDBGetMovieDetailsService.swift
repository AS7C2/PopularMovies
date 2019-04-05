//
//  TMDBGetMovieDetailsService.swift
//  PopularMovies
//
//  Created by Andrei Sherstniuk on 4/4/19.
//  Copyright © 2019 Andrei Sherstniuk. All rights reserved.
//

import Alamofire
import SwiftyJSON

class TMDBGetMovieDetailsService: GetMovieDetailsService {
    private let configuration: TMDBConfiguration
    
    init(configuration: TMDBConfiguration) {
        self.configuration = configuration
    }
    
    func get(byId id: Int, completionHandler: @escaping (Swift.Result<Movie, Error>) -> Void) {
        getMovieDetails(byId: id) { getMovieDetailsResult in
            switch getMovieDetailsResult {
            case .success(let movie):
                self.getYouTubeKey(byId: id) { getYouTubeKeyResult in
                    switch getYouTubeKeyResult {
                    case .success(let key):
                        completionHandler(.success(movie.dtoWithYouTubeKey(key: key)))
                    case .failure:
                        completionHandler(getMovieDetailsResult)
                    }
                }
                break
            case .failure:
                completionHandler(getMovieDetailsResult)
            }
        }
    }
    
    private func getMovieDetails(byId id: Int, completionHandler: @escaping (Swift.Result<Movie, Error>) -> Void) {
        Alamofire
            .request("https://api.themoviedb.org/3/movie/\(id)?api_key=\(configuration.apiKey)")
            .validate()
            .responseData { response in
                switch response.result {
                case .success:
                    if let data = response.result.value {
                        do {
                            let json = try JSON(data: data)
                            if let movie = MovieDTO.fromTMDBJSON(json: json) {
                                completionHandler(.success(movie))
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
    
    private func getYouTubeKey(byId id: Int, completionHandler: @escaping (Swift.Result<String, Error>) -> Void) {
        Alamofire
            .request("https://api.themoviedb.org/3/movie/\(id)/videos?api_key=\(configuration.apiKey)")
            .validate()
            .responseData { response in
                switch response.result {
                case .success:
                    if let data = response.result.value {
                        do {
                            let json = try JSON(data: data)
                            let results = json["results"]
                            if let results = results.array {
                                if let key = self.findYouTubeKey(results: results) {
                                    completionHandler(.success(key))
                                } else {
                                    completionHandler(.failure(TMDBServiceError.unexpectedData))
                                }
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
    
    private func findYouTubeKey(results: [JSON]) -> String? {
        for result in results {
            if let site = result["site"].string {
                if site == "YouTube" {
                    if let key = result["key"].string {
                        return key
                    }
                }
            }
        }
        return nil
    }
}

extension Movie {
    func dtoWithYouTubeKey(key: String) -> MovieDTO {
        return MovieDTO(
            id: id,
            posterPath: posterPath,
            title: title,
            releaseDate: releaseDate,
            overview: overview,
            genres: genres,
            youTubeKey: key)
    }
}
