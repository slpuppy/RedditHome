//
//  RedditHomeViewModel.swift
//  RedditHome
//
//  Created by Gabriel Puppi on 21/05/24.
//

import Foundation

protocol RedditHomeViewModelProtocol {
    var posts: [RedditPost] { get }
    func loadPosts() async -> Result<Void, Error>
}

class RedditHomeViewModel: RedditHomeViewModelProtocol {
    
    let networkingService: RedditHomeDataNetworkingProtocol
    
    var posts: [RedditPost] = []
    
    // MARK: Initialization
    
    init(networkingService: RedditHomeDataNetworkingProtocol = RedditHomeDataNetworkingService()) {
        self.networkingService = networkingService
    }
    
    // MARK: Public Methods
    
    func loadPosts() async -> Result<Void, Error> {
        let result = await networkingService.getHomeData()
        switch result {
        case .success(let posts):
            self.posts = filterThumbnailURL(posts: posts.data.children)
            removeNSFWThumbnails()
            return .success(())
        case .failure(let error):
            return .failure(error)
        }
    }
    
    // MARK: Private Methods
    
    private func filterThumbnailURL(posts: [RedditPost]) -> [RedditPost] {
        let filteredPosts = posts.filter { post in
            let thumbnailURL = post.data.thumbnail
            return !thumbnailURL.contains("external-preview")
        }
        return filteredPosts
    }
    
    private func removeNSFWThumbnails() {
        posts = posts.filter {
            !$0.data.thumbnail.contains("nsfw")
        }
    }


}

