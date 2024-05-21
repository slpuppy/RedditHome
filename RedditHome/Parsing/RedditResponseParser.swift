//
//  RedditResponseParser.swift
//  RedditHome
//
//  Created by Gabriel Puppi on 21/05/24.
//

import Foundation

class RedditResponseParser: RedditResponseParserProtocol {
    func parseHomeData(data: Data) throws -> RedditResponse  {
        return try JSONDecoder().decode(RedditResponse.self, from: data)
    }
}
