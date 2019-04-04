//
//  PopularMoviesTests.swift
//  PopularMoviesTests
//
//  Created by Andrei Sherstniuk on 4/4/19.
//  Copyright © 2019 Andrei Sherstniuk. All rights reserved.
//

import XCTest
@testable import PopularMovies

class GetPopularMoviesInteractorTests: XCTestCase {

    func testEmptyResult() {
        let repository = MoviesRepositorySpy()
        repository.add(movies: [MovieStub(), MovieStub(), MovieStub()]) {result in }
        let service = GetPopularMoviesServiceStub()
        let interactor = GetPopularMoviesInteractor(service: service, repository: repository)
        var moviesCount: Int?
        interactor.get { result in
            switch result {
            case .success(let movies):
                moviesCount = movies.count
            case .failure:
                XCTFail()
            }
        }
        XCTAssertEqual(repository.count, 0)
        XCTAssertEqual(moviesCount, 0)
    }

    func testNotEmptyResult() {
        let repository = MoviesRepositorySpy()
        repository.add(movies: [MovieStub()]) {result in }
        let service = GetPopularMoviesServiceDummy()
        let interactor = GetPopularMoviesInteractor(service: service, repository: repository)
        var moviesCount: Int?
        interactor.get { result in
            switch result {
            case .success(let movies):
                moviesCount = movies.count
            case .failure:
                XCTFail()
            }
        }
        XCTAssertEqual(repository.count, 2)
        XCTAssertEqual(moviesCount, 2)
    }
    
    func testOnSeriveErrorShouldReturnEntitiesFromRepository() {
        let repository = MoviesRepositorySpy()
        repository.add(movies: [MovieStub(), MovieStub(), MovieStub(), MovieStub()]) {result in }
        let service = GetPopularMoviesServiceErrorDummy()
        let interactor = GetPopularMoviesInteractor(service: service, repository: repository)
        var moviesCount: Int?
        interactor.get { result in
            switch result {
            case .success(let movies):
                moviesCount = movies.count
            case .failure:
                XCTFail()
            }
        }
        XCTAssertEqual(moviesCount, 4)
    }
    
    func testFailureOnSeriveSuccessAndRepositoryFailure() {
        let repository = MoviesRepositoryErrorDummy()
        let service = GetPopularMoviesServiceStub()
        let interactor = GetPopularMoviesInteractor(service: service, repository: repository)
        var expectedError: Error?
        interactor.get { result in
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                expectedError = error
            }
        }
        XCTAssertNotNil(expectedError)
    }
    
    func testFailureOnSeriveFailureAndRepositoryFailure() {
        let repository = MoviesRepositoryErrorDummy()
        let service = GetPopularMoviesServiceErrorDummy()
        let interactor = GetPopularMoviesInteractor(service: service, repository: repository)
        var expectedError: Error?
        interactor.get { result in
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                expectedError = error
            }
        }
        XCTAssertNotNil(expectedError)
    }
}
