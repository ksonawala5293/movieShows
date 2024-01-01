//
//  MovieDetailService.swift
//  Movies
//
//  Created by Apple on 30/12/23.
//

import Foundation

typealias detailHandler = (Result<[MovieDetailBaseModel], DataError>) -> ()

protocol MovieDetailsServiceDelegate {
    func callFetchAPI(completion: @escaping(detailHandler))
}

class MovieDetailsService: MovieDetailsServiceDelegate {
    
    func callFetchAPI(completion: @escaping(detailHandler)) {
        
    }
}
