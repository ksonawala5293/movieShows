//
//  DashboardService.swift
//  Movies
//
//  Created by Apple on 30/12/23.
//

import Foundation

typealias Handler = (Result<[NowPlayingBaseModel], DataError>) -> ()

protocol DashboardServiceDelegate {
    func callFetchAPIForPopularMovies(for type: movieType, page: Int, completion: @escaping(Result<PopularMoviesBaseModel, DataError>) -> ())
    func callFetchAPIForNowPlayingMovies(for type: movieType, page: Int, completion: @escaping(Result<NowPlayingBaseModel, DataError>) -> ())
}

class DashboardService: DashboardServiceDelegate {
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
