//
//  PostDetailsView.swift
//  RedditHome
//
//  Created by Gabriel Puppi on 21/05/24.
//

import SwiftUI


struct PostDetailsView: View {
    
    @State var postData: PostData
    
    var body: some View {
        Text(postData.title)
    }
}

//#Preview {
//    PostDetailsView()
//}
