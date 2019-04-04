//
//  GetPopularMoviesInteractor.swift
//  PopularMovies
//
//  Created by Andrei Sherstniuk on 4/4/19.
//  Copyright © 2019 Andrei Sherstniuk. All rights reserved.
//

class GetPopularMoviesInteractor {
    private let service: GetPopularMoviesService
    private let repository: MoviesRepository
    
    init(service: GetPopularMoviesService, repository: MoviesRepository) {
        self.service = service
        self.repository = repository
    }
    
    func get(completionHandler: @escaping (Result<[Movie], Error>) -> Void) {
        return service.get { result in
            switch result {
            case .success(let movies):
                for movie in movies {
                    self.repository.save(movie: movie)
                }
                completionHandler(result)
            case.failure(_):
                break
            }
        }
    }
}
