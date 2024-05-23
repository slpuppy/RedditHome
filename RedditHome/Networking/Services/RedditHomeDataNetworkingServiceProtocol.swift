//
//  RedditHomeDataNetworkingServiceProtocol.swift
//  RedditHome
//
//  Created by Gabriel Puppi on 21/05/24.
//

import Foundation

protocol RedditHomeDataNetworkingProtocol {
    func getHomeData() async -> Result<RedditResponse, Error>
}
