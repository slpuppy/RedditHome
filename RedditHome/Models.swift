//
//  Models.swift
//  RedditHome
//
//  Created by Gabriel Puppi on 21/05/24.
//

import Foundation

struct RedditResponse: Codable {
    let kind: String
    let data: RedditData
}

struct RedditData: Codable {
   let children: [RedditPost]
}

struct RedditPost: Codable {
    let kind: String
    let data: PostData
}

struct PostData: Codable {
    let subreddit: String
    let selftext: String
    let author_fullname: String?
    let title: String
    let downs: Int
    let name: String
    let ups: Int
    let thumbnail: String
    let created: Int
    let selftext_html: String?
    let likes: Int?
    let view_count: Int?
    let id: String
    let author: String
    let num_comments: Int
    let postID: String?
    let url: String
    let created_utc: Int
}

