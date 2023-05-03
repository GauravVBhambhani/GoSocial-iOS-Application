//
//  ThoughtRowView.swift
//  GoSocialFinal
//
//  Created by Gaurav Bhambhani on 4/26/23.
//

import SwiftUI
import Kingfisher

struct ThoughtRowView: View {
    
    @ObservedObject var viewModel: ThoughtRowViewModel
    
    init(thought: Thought) {
        self.viewModel = ThoughtRowViewModel(thought: thought)
    }
    
    var body: some View {
        
        VStack (alignment: .leading) {
            
            //profile image, user info, tweet
            if let user = viewModel.thought.user {
                HStack (alignment: .top, spacing: 12) {
                    KFImage(URL(string: user.dpImageUrl))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 56, height: 56)
                        .clipShape(Circle())
                        
                    
                    //user info, tweet
                    VStack (alignment: .leading, spacing: 4) {
                        
                        //user info
                        HStack {
                            Text(user.fullname)
                                .font(.subheadline).bold()
                            
                            Text("@\(user.username)")
                                .foregroundColor(.gray)
                                .font(.caption)

                        }
                        
                        //thought
                        Text (viewModel.thought.caption)
                            .font(.subheadline)
                            .multilineTextAlignment(.leading)
                    }
                    
                }
            }
            
            //action buttons
            HStack {
                Button {
                    //action
                } label: {
                    Image(systemName: "bubble.left")
                        .font(.subheadline)
                }
                Spacer()
                Button {
                    //action
                } label: {
                    Image(systemName: "arrow.2.squarepath")
                        .font(.subheadline)
                }
                Spacer()
                Button {
                    //action
                    viewModel.thought.didLike ?? false ? viewModel.unlikeThought() : viewModel.likeThought()
                } label: {
                    Image(systemName: viewModel.thought.didLike ?? false ? "heart.fill" : "heart")
                        .font(.subheadline)
                        .foregroundColor(viewModel.thought.didLike ?? false ? .red : .gray)
                }
                Spacer()
                Button {
                    //action
                } label: {
                    Image(systemName: "bookmark")
                        .font(.subheadline)
                }
            }.padding().foregroundColor(.gray)
            
            Divider()
        }
        .padding()
    }
}

