//
//  GetPopularMoviesInteractor.swift
//  PopularMovies
//
//  Created by Andrei Sherstniuk on 4/4/19.
//  Copyright © 2019 Andrei Sherstniuk. All rights reserved.
//

class GetPopularMoviesInteractor: GetMoviesInteractor {
    private let service: GetPopularMoviesService
    private let repository: MoviesRepository
    
    init(service: GetPopularMoviesService, repository: MoviesRepository) {
        self.service = service
        self.repository = repository
    }
    
    func get(completionHandler: @escaping (Result<[Movie], Error>) -> Void) {
        return service.get { getResult in
            // TODO: replace nested switch with RxSwift
            switch getResult {
            case .success(let movies):
                self.repository.clear { clearResult in
                    switch clearResult {
                    case .success:
                        self.repository.add(movies: movies) { saveResult in
                            switch saveResult {
                            case .success:
                                completionHandler(getResult)
                            case .failure(let error):
                                completionHandler(.failure(error))
                            }
                        }
                    case .failure(let error):
                        completionHandler(.failure(error))
                    }
                }
            case.failure:
                self.repository.getAll { getAllResult in
                    completionHandler(getAllResult)
                }
            }
        }
    }
}
