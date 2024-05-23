//
//  ApiEndpointProtocol + Extension.swift
//  RedditHome
//
//  Created by Gabriel Puppi on 21/05/24.
//

import Foundation

import Foundation

// MARK: - Default values

extension ApiEndpointProtocol {
    var domain: String { "reddit.com" }
    var body: Data? { nil }
    var method: HTTPMethod { .get }
}

// MARK: - URL building

extension ApiEndpointProtocol {
    
    private var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = domain
        
        guard let url = components.url?
            .appendingPathComponent(path)
                
        else { fatalError("Invalid url! \(self)") }
        
        print(url)
        return url
    }
    
    var request: URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        if let body {
            request.httpBody = body
        }
        return request
    }
}

