//
//  PostContentView.swift
//  RedditHome
//
//  Created by Gabriel Puppi on 22/05/24.
//

import SwiftUI

struct PostContentView: View {
    
    let postData: PostData
    
    var body: some View {
        VStack(spacing: 16) {
            HStack{
                Text(postData.title)
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(.white)
                Spacer()
            }
            
            if let thumbnailURL = URL(string: postData.thumbnail),
               !["self", "default", "external"].contains(postData.thumbnail) {
                AsyncImageView(url: thumbnailURL)
            }
            
            if !postData.selftext.isEmpty {
                Text(postData.selftext)
                    .font(.system(size: 14))
                    .foregroundStyle(.white)
            }
        }
    }
}
