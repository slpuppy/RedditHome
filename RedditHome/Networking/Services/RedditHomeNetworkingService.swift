//
//  RedditHomeNetworkingService.swift
//  RedditHome
//
//  Created by Gabriel Puppi on 21/05/24.
//

import Foundation

class RedditHomeDataNetworkingService: RedditHomeDataNetworkingProtocol {
    
    let parser: RedditResponseParserProtocol
    let session: URLSession
    
    init(parser: RedditResponseParserProtocol = RedditResponseParser()) {
        self.parser = parser
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 15
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        session = URLSession(configuration: configuration)
    }
    
    
    func getHomeData() async -> Result<RedditResponse, Error> {
        
        let endpoint = RedditEndpoint.json
        
        do {
            let (data, _) = try await session.data(for: endpoint.request)
            let parsedData = try parser.parseHomeData(data: data)
            return .success(parsedData)
        } catch {
            if let urlError = error as? URLError, urlError.code == .timedOut {
                return .failure(APIErrorResponse(status: "408", code: "timedOut", message: "Request timed out"))
            }
            print(error)
            return .failure(error)
        }

    }
    
    
    
    
}
