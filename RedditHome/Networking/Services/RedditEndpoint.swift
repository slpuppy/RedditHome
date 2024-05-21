//
//  RedditEndpoint.swift
//  RedditHome
//
//  Created by Gabriel Puppi on 21/05/24.
//

import Foundation

enum RedditEndpoint: ApiEndpointProtocol {
    
    case json
    
    var path: String {
        switch self {
        case .json:
            return ".json"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case  .json:
            return .get
        }
    }
}
