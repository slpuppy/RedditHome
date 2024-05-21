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
    let saved: Bool
    let mod_reason_title: String?
    let gilded: Int
    let clicked: Bool
    let title: String
    let hidden: Bool
    let pwls: Int?
    let downs: Int
    let thumbnail_height: Int?
    let top_awarded_type: String?
    let hide_score: Bool
    let name: String
    let quarantine: Bool
    let upvote_ratio: Double
    let subreddit_type: String
    let ups: Int
    let total_awards_received: Int
    let thumbnail_width: Int?
    let is_original_content: Bool
    let user_reports: [String]?
    let secure_media: Media?
    let category: String?
    let score: Int
    let approved_by: String?
    let author_premium: Bool
    let thumbnail: String
    let post_hint: String?
    let content_categories: [String]?
    let is_self: Bool
    let mod_note: String?
    let created: Int
    let wls: Int?
    let domain: String
    let selftext_html: String?
    let likes: Int?
    let view_count: Int?
    let archived: Bool
    let pinned: Bool
    let media_only: Bool
    let spoiler: Bool
    let locked: Bool
    let visited: Bool
    let removed_by: String?
    let num_reports: Int?
    let distinguished: String?
    let subreddit_id: String
    let id: String
    let author: String
    let discussion_type: String?
    let num_comments: Int
    let postID: String?
    let permalink: String
    let stickied: Bool
    let url: String
    let subreddit_subscribers: Int
    let created_utc: Int
    let is_video: Bool
    let media: Media?
    let preview: Preview?
}

struct Media: Codable {
    let oembed: OEmbed?
    let type: String?
}

struct OEmbed: Codable {
    let provider_url: String
    let thumbnail_url: String
 }


struct Preview: Codable {
    let images: [Image]
    let enabled: Bool
}

struct Image: Codable {
    let source: Source
    let resolutions: [Source]
    let id: String
}

struct Source: Codable {
    let url: String
    let width: Int
    let height: Int
}

