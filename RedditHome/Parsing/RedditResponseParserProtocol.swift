//
//  RedditResponseParserProtocol.swift
//  RedditHome
//
//  Created by Gabriel Puppi on 21/05/24.
//

import Foundation

protocol RedditResponseParserProtocol {
    func parseHomeData(data: Data) throws -> RedditResponse
}

