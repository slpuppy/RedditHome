//
//  PostData.swift
//  RedditHome
//
//  Created by Gabriel Puppi on 21/05/24.
//

import Foundation

struct PostData: Codable {
    let subreddit: String
    let selftext: String
    let title: String
    let name: String
    let ups: Int
    let thumbnail: String
    let created: Int
    let id: String
    let author: String
    let num_comments: Int
    let postID: String?
    let url: String
    let created_utc: Int
}

