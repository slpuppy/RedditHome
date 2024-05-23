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
    let createdUTC: Int
    
    var body: some View {
        HStack {
            UpVotesView(upVotesCount: upVotesCount)
            Text(author)
                .font(.system(size: 12, weight: .semibold))
                .foregroundStyle(.white)
            Spacer()
            if let dateString = createdUTC.formattedDateString() {
                Text(dateString)
                    .font(.system(size: 12))
                    .foregroundStyle(.white)
            }
        }
    }
}
