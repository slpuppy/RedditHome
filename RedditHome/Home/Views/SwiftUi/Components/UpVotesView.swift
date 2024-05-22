//
//  UpVotesView.swift
//  RedditHome
//
//  Created by Gabriel Puppi on 22/05/24.
//

import SwiftUI

struct UpVotesView: View {
    
    @State var upVotesCount: Int
    
    var body: some View {
        ZStack {
            HStack (spacing: 4){
                Image(systemName: "arrow.up.circle")
                    .foregroundStyle(.white)
                    .frame(width: 16, height: 16)
                Text("\(upVotesCount)")
                    .foregroundStyle(.white)
                    .font(.system(size: 12, weight: .bold))
            }
            .padding(6)
            .background(Color(hex: "171717"))
            
        }.clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    UpVotesView(upVotesCount: 666)
}
