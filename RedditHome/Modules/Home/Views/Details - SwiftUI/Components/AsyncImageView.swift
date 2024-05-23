//
//  AsyncImageView.swift
//  RedditHome
//
//  Created by Gabriel Puppi on 22/05/24.
//
import SwiftUI

struct AsyncImageView: View {
    let url: URL
    
    var body: some View {
        AsyncImage(url: url) { result in
            result.image?
                .resizable()
                .scaledToFill()
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

