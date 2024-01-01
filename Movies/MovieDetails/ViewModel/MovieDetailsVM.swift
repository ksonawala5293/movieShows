//
//  MovieDetailsVM.swift
//  Movies
//
//  Created by Apple on 30/12/23.
//

import Foundation

class MovieDetailsVM {
    
    var movieDetailsBaseModel: MovieDetailBaseModel?
    var eventListner: ((_ event: Listeners) -> ())?
    
    private let dashboardService: DashboardServiceDelegate
    init(dashboardService: DashboardServiceDelegate = DashboardService()) {
        self.dashboardService = dashboardService
    }
    
    func callFetchAPI(for id: Int) {
        self.eventListner?(.startLoading)
        print("api calling for \(id)")
        APIManager.shared.request(modelType: MovieDetailBaseModel.self,
                                  type: EndPointMovieDetails.movieDetail(id: id)) { response in
            self.eventListner?(.stopLoading)
            switch response {
            case .success(let baseModel):
                self.movieDetailsBaseModel = baseModel
                self.eventListner?(.dataReceived)
            case .failure(let error):
                self.eventListner?(.error(error))
            }
        }
    }
    
    enum Listeners {
        case startLoading
        case stopLoading
        case dataReceived
        case error(DataError?)
    }
}
