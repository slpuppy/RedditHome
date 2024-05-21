//
//  ApiEndPointProtocol.swift
//  RedditHome
//
//  Created by Gabriel Puppi on 21/05/24.
//

import Foundation

protocol ApiEndpointProtocol {
    var domain: String { get }
    var path: String { get }
    var body: Data? { get }
    var method: HTTPMethod { get }
}
