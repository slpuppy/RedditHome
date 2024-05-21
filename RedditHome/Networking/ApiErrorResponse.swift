//
//  ApiErrorResponse.swift
//  RedditHome
//
//  Created by Gabriel Puppi on 21/05/24.
//

import Foundation

struct APIErrorResponse: Decodable, Error {
    let status: String
    let code: String?
    let message: String?
}
