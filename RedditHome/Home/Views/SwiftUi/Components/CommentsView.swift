//
//  CommentsView.swift
//  RedditHome
//
//  Created by Gabriel Puppi on 22/05/24.
//

import SwiftUI

struct CommentsView: View {
    
    @State var commentsCount: Int
    
    var body: some View {
            HStack (alignment: .center, spacing: 6){
                Image(systemName: "bubble.left")
                    .foregroundStyle(.white)
                    .frame(width: 16, height: 16)
                Text("\(commentsCount) comments")
                    .foregroundStyle(.white)
                    .font(.system(size: 12, weight: .semibold))
                Spacer()
            }
   }
}

#Preview {
    CommentsView(commentsCount: 43782)
}
