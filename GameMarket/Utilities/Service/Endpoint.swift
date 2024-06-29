//
//  Endpoint.swift
//  GameMarket
//
//  Created by Okan Orkun on 3.06.2024.
//

import Foundation

enum NetworkError: Error {
    case invalidResponse
    case urlError(_ url: URLError)
}

protocol EndpointProtocol {
    var baseURL: String { get }
    var path: String { get }
    var apiKey: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }

    func request() async throws -> URLRequest
}

enum HTTPMethod: String {
    case get
    
    var HTTPValue: String {
        return self.rawValue.uppercased()
    }
}

enum Endpoint {
    case getGames
    case searchGame(query: String)
}

extension Endpoint: EndpointProtocol {

    var baseURL: String {
        return AppConstants.NetworkConstants.baseURL.rawValue
    }

    var path: String {
        switch self {
        case .getGames:
            return AppConstants.NetworkConstants.games.rawValue + AppConstants.NetworkConstants.date
        case .searchGame(let query):
            return AppConstants.NetworkConstants.games.rawValue + AppConstants.NetworkConstants.date + AppConstants.NetworkConstants.search.rawValue + query + AppConstants.NetworkConstants.searchPrecise.rawValue + AppConstants.NetworkConstants.metaCritic.rawValue
        }
    }
    
    var apiKey: String {
        return AppConstants.NetworkConstants.apiKey.rawValue
    }

    var method: HTTPMethod {
        switch self {
        case .getGames, .searchGame:
            return .get
        }
    }
    
    var headers: [String : String] {
        return [:]
    }

    func request() async throws -> URLRequest {
        guard let url = URL(string: baseURL + path + apiKey) else {
            fatalError("Invalid URL")
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        
        return request
    }
}
