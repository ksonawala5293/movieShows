//
//  EndPointMovieDetails.swift
//  Movies
//
//  Created by Apple on 30/12/23.
//

import Foundation

enum EndPointMovieDetails {
    case movieDetail(id: Int)
}

extension EndPointMovieDetails: EndPoints, GetParameters {
    
    var path: String {
        switch self {
        case .movieDetail(let id):
            return "\(id)"
        }
    }

    var baseURL: String {
        switch self {
        case .movieDetail:
            return "\(Constant.baseURL)3/movie/"
        }
    }

    var url: URL? {
        return URL(string: "\(baseURL)\(path)\(getParameters)")
    }
    
    var getParameters: String {
        switch self {
        case .movieDetail:
            return "?language=en-US&api_key=\(Constant.apiKey)"
        }
    }

    var method: HTTPMethods {
        switch self {
        case .movieDetail:
            return .get
        }
    }

    var body: Encodable? {
        switch self {
        case .movieDetail:
            return nil
        }
    }
}

