//
//  FeedView.swift
//  GoSocialFinal
//
//  Created by Gaurav Bhambhani on 4/26/23.
//

import SwiftUI

struct FeedView: View {
    
    @State private var showNewThoughtView = false
    @ObservedObject var viewModel = FeedViewModel()
    
    var body: some View {
        NavigationView {
            ZStack (alignment: .bottomTrailing) {
                ScrollView {
                    LazyVStack {
                        ForEach (viewModel.thoughts) { thought in
                            ThoughtRowView(thought: thought)
                        }
                    }
                    
                    // Add a refresh button to refresh the content
                    Button(action: {
                        viewModel.fetchThoughts()
                    }, label: {
                        Image(systemName: "arrow.clockwise")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .padding()
                    })
                }
                
                Button {
                    showNewThoughtView.toggle()
                } label: {
                    Image(systemName: "pencil")
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 28, height: 28)
                        .padding()
                }
                .background(Color(.systemBlue))
                .foregroundColor(.white)
                .clipShape(Circle())
                .padding()
                .fullScreenCover(isPresented: $showNewThoughtView, onDismiss: {
                    viewModel.fetchThoughts()
                }) {
                    NewThoughtView()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                viewModel.fetchThoughts()
            }
        }
    }
}


struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
