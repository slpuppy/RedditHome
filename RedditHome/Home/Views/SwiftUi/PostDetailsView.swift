//
//  PostDetailsView.swift
//  RedditHome
//
//  Created by Gabriel Puppi on 21/05/24.
//

import SwiftUI


struct PostDetailsView: View {
    
//    @State var postData: PostData
    
    var body: some View {
        ZStack{
            Color.black
            VStack(alignment: .leading){
                Text("This is the post title")
                    .foregroundStyle(.white)
                AsyncImage(url: URL(string: "https://b.thumbs.redditmedia.com/8Duij77HU7TJoNaq7cH-QUNC4yLA0ymcOoVc9xaKsKE.jpg"), scale: 0.4)
            }
        }
    }
}

#Preview {
   
    PostDetailsView()
}
