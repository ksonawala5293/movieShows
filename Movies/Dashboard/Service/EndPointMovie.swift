//
//  EndPointMovie.swift
//  Movies
//
//  Created by Apple on 30/12/23.
//

import Foundation

enum EndPointMovie {
    case movies(movieType: movieType, page: Int = 1)
}

extension EndPointMovie: EndPoints, GetParameters {
    
    var path: String {
        switch self {
        case .movies(let movieType, _):
            return movieType.rawValue
        }
    }

    var baseURL: String {
        switch self {
        case .movies:
            return "\(Constant.baseURL)3/movie/"
        }
    }

    var url: URL? {
        return URL(string: "\(baseURL)\(path)\(getParameters)")
    }
    
    var getParameters: String {
        switch self {
        case .movies(_, let page):
            return "?language=en-US&page=\(page)&api_key=\(Constant.apiKey)"
        }
    }

    var method: HTTPMethods {
        switch self {
        case .movies:
            return .get
        }
    }

    var body: Encodable? {
        switch self {
        case .movies:
            return nil
        }
    }
}
