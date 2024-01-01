//
//  MockDashboardService.swift
//  MoviesTests
//
//  Created by Apple on 01/01/24.
//

import Foundation
@testable import Movies

class MockDashboardService: DashboardServiceDelegate {
    var resultForPopularMovies: Result<PopularMoviesBaseModel, DataError>!
    var resultForNowPlayingMovies: Result<NowPlayingBaseModel, DataError>!
    
    func callFetchAPIForPopularMovies(for type: movieType, page: Int, completion: @escaping (Result<PopularMoviesBaseModel, DataError>) ->()) {
        APIManager.shared.request(modelType: PopularMoviesBaseModel.self,
                                  type: EndPointMovie.movies(movieType: type, page: page)) { response in
            completion(response)
        }
    }
    
    func callFetchAPIForNowPlayingMovies(for type: movieType, page: Int, completion: @escaping(Result<NowPlayingBaseModel, DataError>) -> ()) {
        APIManager.shared.request(modelType: NowPlayingBaseModel.self,
                                  type: EndPointMovie.movies(movieType: type, page: page)) { response in
            completion(response)
        }
    }
}
