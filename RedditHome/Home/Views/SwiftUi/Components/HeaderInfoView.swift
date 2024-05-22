//
//  HeaderInfoView.swift
//  RedditHome
//
//  Created by Gabriel Puppi on 22/05/24.
//

import SwiftUI

struct HeaderInfoView: View {
    let author: String
    let upVotesCount: Int
    
    var body: some View {
        HStack {
            UpVotesView(upVotesCount: upVotesCount)
            Text(author)
                .font(.system(size: 12, weight: .semibold))
                .foregroundStyle(.white)
            
            Spacer()
        }
    }
}
