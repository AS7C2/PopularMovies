//
//  GetPopularMoviesInteractor.swift
//  PopularMovies
//
//  Created by Andrei Sherstniuk on 4/4/19.
//  Copyright © 2019 Andrei Sherstniuk. All rights reserved.
//

class GetPopularMoviesInteractor {
    private let service: GetPopularMoviesService
    
    init(service: GetPopularMoviesService) {
        self.service = service
    }
    
    func execute(completionHandler: @escaping (Result<[Movie], Error>) -> Void) {
        return service.execute(completionHandler: completionHandler)
    }
}
