//
//  ProfileView.swift
//  GoSocialFinal
//
//  Created by Gaurav Bhambhani on 4/26/23.
//

import SwiftUI
import Kingfisher

struct ProfileView: View {
    
    @State private var selectedFilter: ThoughtFilterViewModel = .thoughts
    @ObservedObject var viewModel: ProfileViewModel
    @Namespace var animation
    @Environment(\.presentationMode) var mode
        
    init(user: User) {
        self.viewModel = ProfileViewModel(user: user)
    }
    
    var body: some View {
        VStack (alignment: .leading) {
            
            headerView
            
            actionButtons
            
            userInfoDetails
            
            thoughtsFilterBar
            
            thoughtsView
            
            Spacer()
            
        }
        .navigationBarHidden(true)
        .onAppear {
            viewModel.fetchUserThoughts()
            viewModel.fetchLikedThoughts()
        }
    }
}


extension ProfileView {
    
    var headerView: some View {
        ZStack (alignment: .bottomLeading) {
            Color(.systemBlue)
                .ignoresSafeArea()
            
            VStack {
                Button {
                    //action
                    mode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .frame(width: 20, height: 16)
                        .foregroundColor(.white)
                        .offset(x:16, y:-4)
                }
                
                KFImage(URL(string: viewModel.user.dpImageUrl))
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 72, height: 72)
                    .offset(x:16, y: 24)
            }
        }
        .frame(height: 96)
    }
    
    var actionButtons: some View {
        HStack(spacing: 12) {
            Spacer()
            
            Image(systemName: "bell.badge")
                .font(.title3)
                .padding(6)
                .overlay(Circle().stroke(Color.gray, lineWidth: 0.75))
            
            Button {
                //action
            } label: {
                Text(viewModel.actionButtonTitle)
                    .font(.subheadline).bold()
                    .frame(width: 120, height: 32)
                    .foregroundColor(.black)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray, lineWidth: 0.75))
            }
        }.padding(.trailing)
    }
    
    var userInfoDetails: some View {
        VStack (alignment: .leading, spacing: 4) {
            HStack {
                Text(viewModel.user.fullname)
                    .font(.title2).bold()
                
                Image(systemName: "checkmark.seal.fill")
                    .foregroundColor(Color(.systemBlue))
            }
            
            Text ("@\(viewModel.user.username)")
                .foregroundColor(.gray)
                .font(.subheadline)
            
            Text("I want to put a ding in the universe.")
                .font(.subheadline)
                .padding(.vertical)
            
            
            HStack (spacing: 24) {
                HStack {
                    Image(systemName: "mappin.and.ellipse")
                    Text("Cupertino, CA")
                }

                HStack {
                    Image(systemName: "link")
                    Text("www.apple.com")
                }
                
            }
            .foregroundColor(.gray)
            .font(.subheadline)
            
            UsersStatsView()
        }
        .padding(.horizontal)
    }
    
    var thoughtsFilterBar: some View {
        HStack {
            ForEach(ThoughtFilterViewModel.allCases, id: \.rawValue) { item in
                VStack {
                    Text (item.title)
                        .font(.subheadline)
                        .fontWeight(selectedFilter == item ? .semibold : .regular)
                        .foregroundColor(selectedFilter == item ? .black : .gray)
                    
                    if selectedFilter == item {
                        Capsule()
                            .foregroundColor(Color(.systemBlue))
                            .frame(height: 3)
                            .matchedGeometryEffect(id: "filter", in: animation)
                    }
                    else {
                        Capsule()
                            .foregroundColor(Color(.clear))
                            .frame(height: 3)
                    }
                }
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        self.selectedFilter = item
                    }
                }
            }
        }
        .overlay(Divider().offset(x:0, y:16))
    }
    
    var thoughtsView: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.thoughts(forFilter: self.selectedFilter)) { thought in
                    ThoughtRowView(thought: thought)
                        .padding()
                }
            }
        }
    }
}
