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
    func presentPost(postIndex: Int)
}

class RedditHomeViewModel: RedditHomeViewModelProtocol {
    
    weak var coordinator: Coordinator?
    
    let networkingService: RedditHomeDataNetworkingProtocol
    
    var posts: [RedditPost] = []
    
    // MARK: Initialization
    
    init(networkingService: RedditHomeDataNetworkingProtocol = RedditHomeDataNetworkingService(), coordinator: Coordinator) {
        self.coordinator = coordinator
        self.networkingService = networkingService
    }
    
    // MARK: Public Methods
    
    func loadPosts() async -> Result<Void, Error> {
        let result = await networkingService.getHomeData()
            switch result {
            case .success(let posts):
                self.posts = self.filterThumbnailURL(posts: posts.data.children)
                return .success(())
            case .failure(let error):
                return .failure(error)
            }
    }
    
func presentPost(postIndex: Int){
    let postData = posts[postIndex].data
        coordinator?.presentPost(postData: postData)
    }
    
    // MARK: Private Methods
    
    private func filterThumbnailURL(posts: [RedditPost]) -> [RedditPost] {
        let filteredPosts = posts.filter { post in
            let thumbnailURL = post.data.thumbnail
            return thumbnailURL.contains("thumbs.redditmedia.com") && thumbnailURL.hasSuffix(".jpg")
        }
        return filteredPosts
    }
}

