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
        let service = GetPopularMoviesServiceStub()
        let interactor = GetPopularMoviesInteractor(service: service)
        var moviesCount: Int?
        interactor.execute { result in
            switch result {
            case .success(let movies):
                moviesCount = movies.count
            case .failure(_):
                XCTFail()
            }
        }
        XCTAssertEqual(moviesCount, 0)
    }

}
