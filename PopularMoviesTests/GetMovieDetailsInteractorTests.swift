//
//  GetMovieDetailsInteractorTests.swift
//  PopularMoviesTests
//
//  Created by Andrei Sherstniuk on 4/4/19.
//  Copyright © 2019 Andrei Sherstniuk. All rights reserved.
//

import XCTest
@testable import PopularMovies

class GetMovieDetailsInteractorTests: XCTestCase {
    func testSuccess() {
        let service = GetMovieDetailsServiceFake(movie: MovieFake(id: 12345))
        let repository = MoviesRepositorySpy()
        repository.add(movies: [MovieFake(id: 12345)]) { result in }
        let interactor = DefaultGetMovieDetailsInteractor(service: service, repository: repository)
        var expectedMovie: Movie?
        interactor.get(byId: 12345) { result in
            switch (result) {
            case .success(let movie):
                expectedMovie = movie
            case .failure:
                XCTFail()
            }
        }
        XCTAssertNotNil(expectedMovie)
    }
    
    func testServiceFailRepositorySuccess() {
        let service = GetMovieDetailsServiceErrorDummy()
        let repository = MoviesRepositorySpy()
        repository.add(movies: [MovieFake(id: 12345)]) { result in }
        let interactor = DefaultGetMovieDetailsInteractor(service: service, repository: repository)
        var expectedMovie: Movie?
        interactor.get(byId: 12345) { result in
            switch (result) {
            case .success(let movie):
                expectedMovie = movie
            case .failure:
                XCTFail()
            }
        }
        XCTAssertNotNil(expectedMovie)
    }
    
    func testServiceFailRepositoryFail() {
        let service = GetMovieDetailsServiceErrorDummy()
        let repository = MoviesRepositoryErrorDummy()
        let interactor = DefaultGetMovieDetailsInteractor(service: service, repository: repository)
        var expectedError: Error?
        interactor.get(byId: 12345) { result in
            switch (result) {
            case .success:
                XCTFail()
            case .failure(let error):
                expectedError = error
            }
        }
        XCTAssertNotNil(expectedError)
    }
    
    func testServiceSuccessRepositoryFail() {
        let service = GetMovieDetailsServiceFake(movie: MovieFake(id: 12345))
        let repository = MoviesRepositoryErrorDummy()
        let interactor = DefaultGetMovieDetailsInteractor(service: service, repository: repository)
        var expectedError: Error?
        interactor.get(byId: 12345) { result in
            switch (result) {
            case .success:
                XCTFail()
            case .failure(let error):
                expectedError = error
            }
        }
        XCTAssertNotNil(expectedError)
    }
}
