//
//  DefaultGetMovieDetailsInteractor.swift
//  PopularMovies
//
//  Created by Andrei Sherstniuk on 4/4/19.
//  Copyright © 2019 Andrei Sherstniuk. All rights reserved.
//

class DefaultGetMovieDetailsInteractor: GetMovieDetailsInteractor {
    let service: GetMovieDetailsService
    let repository: MoviesRepository
    
    init(service: GetMovieDetailsService, repository: MoviesRepository) {
        self.service = service
        self.repository = repository
    }
    
    func get(byId id: Int, completionHandler: @escaping (Result<Movie, Error>) -> Void) {
        service.get(byId: id) { getResult in
            switch getResult {
            case .success(let movie):
                self.repository.update(movie: movie) { updateResult in
                    switch updateResult {
                    case .success:
                        completionHandler(.success(movie))
                    case .failure(let error):
                        completionHandler(.failure(error))
                    }
                }
            case .failure:
                self.repository.get(byId: id) { result in
                    completionHandler(result)
                }
            }
        }
    }
}
