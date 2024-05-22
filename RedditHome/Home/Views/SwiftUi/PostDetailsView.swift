import SwiftUI

struct PostDetailsView: View {
    @State var postData: PostData
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 16) {
                    HeaderInfoView(author: postData.author, upVotesCount: postData.ups)
                    PostContentView(postData: postData)
                    CommentsView(commentsCount: postData.num_comments)
                }
                .padding(16)
                .background(Color(hex: "212121"))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .padding(.bottom, 16)
        }
        .padding(16)
        .background(Color(hex: "171717"))
        .ignoresSafeArea(edges: [.bottom])
    }
}





