//
//  DashboardVM.swift
//  Movies
//
//  Created by Apple on 30/12/23.
//

import Foundation

enum Listeners {
    case startLoading
    case stopLoading
    case dataReceived (movieType: movieType)
    case error(DataError?)
}

class DashboardVM {
    
    var nowPlayingBaseModel: NowPlayingBaseModel?
    var popularBaseModel: PopularMoviesBaseModel?
    
    var arrNowPlaying = [NowPlayingResultsModel]()
    var arrPopular = [PopularMoviesResult]()
    
    var popularMovieListpageNo = 1
    
    var eventListner: ((_ event: Listeners) -> ())?
    
    private let dashboardService: DashboardServiceDelegate
    init(dashboardService: DashboardServiceDelegate = DashboardService()) {
        self.dashboardService = dashboardService
    }
    
    func callFetchAPIForNowPlayingMovies(for type: movieType, page: Int) {
        self.eventListner?(.startLoading)
        print("api calling for \(type) & page=\(page)")
        APIManager.shared.request(modelType: NowPlayingBaseModel.self,
                                  type: EndPointMovie.movies(movieType: type, page: page)) { response in
            self.eventListner?(.stopLoading)
            switch response {
            case .success(let baseModel):
                self.nowPlayingBaseModel = baseModel
                self.arrNowPlaying += baseModel.results ?? []
                self.nowPlayingBaseModel?.results = self.arrNowPlaying
                
                self.eventListner?(.dataReceived(movieType: type))
            case .failure(let error):
                self.eventListner?(.error(error))
            }
        }
    }
    
    func callFetchAPIForPopularMovies(for type: movieType, page: Int) {
        self.eventListner?(.startLoading)
        print("api calling for \(type) & page=\(page)")
        APIManager.shared.request(modelType: PopularMoviesBaseModel.self,
                                  type: EndPointMovie.movies(movieType: type, page: page)) { response in
            self.eventListner?(.stopLoading)
            switch response {
            case .success(let baseModel):
                self.popularBaseModel = baseModel
                self.arrPopular += baseModel.results ?? []
                self.popularBaseModel?.results = self.arrPopular
                
                self.eventListner?(.dataReceived(movieType: type))
            case .failure(let error):
                self.eventListner?(.error(error))
            }
        }
    }
}
