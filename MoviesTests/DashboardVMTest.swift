//
//  DashboardVMTest.swift
//  MoviesTests
//
//  Created by Apple on 01/01/24.
//

import XCTest
@testable import Movies

class DashboardVMTest: XCTestCase {
    func testAPIFailure() {
        let mockService = MockDashboardService()
        mockService.resultForPopularMovies = .failure(.invalidResponse)
        let sut = DashboardVM(dashboardService: mockService)
        sut.callFetchAPIForPopularMovies(for: .popular, page: 1)
        XCTAssert(sut.arrPopular.isEmpty)
    }
    
    func testAPISuccess() {
        let mockService = MockDashboardService()
        
        var baseModel: PopularMoviesBaseModel?
        mockService.callFetchAPIForPopularMovies(for: .popular, page: 1) { response in
            switch response {
            case .success(let data):
                baseModel = data
            case .failure(_):
                baseModel = nil
            }
        }
        
        guard let model = baseModel else {return}
        mockService.resultForPopularMovies = .success(model)
        let sut = DashboardVM(dashboardService: mockService)
        sut.callFetchAPIForPopularMovies(for: .popular, page: 1)
        XCTAssert(sut.popularBaseModel?.results?.count != 0)
    }
}
