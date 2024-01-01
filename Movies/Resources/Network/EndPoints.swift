//
//  EndPoint.swift
//  Movies
//
//  Created by Apple on 30/12/23.
//

import Foundation

enum HTTPMethods: String {
    case get = "GET"
    case post = "POST"
}

protocol EndPoints {
    var path: String { get }
    var baseURL: String { get }
    var url: URL? { get }
    var method: HTTPMethods { get }
    var body: Encodable? { get }
}

protocol GetParameters {
    var getParameters: String { get }
}
