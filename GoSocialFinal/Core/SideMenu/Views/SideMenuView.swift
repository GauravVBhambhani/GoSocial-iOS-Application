//
//  SideMenuView.swift
//  GoSocialFinal
//
//  Created by Gaurav Bhambhani on 4/26/23.
//

import SwiftUI
import Kingfisher

struct SideMenuView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        if let user = authViewModel.currentUser {
            
            VStack (alignment: .leading, spacing: 32) {
                VStack(alignment: .leading) {
                    KFImage(URL(string: user.dpImageUrl))
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 48, height: 48)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(user.fullname)
                            .font(.subheadline)
                        
                        Text("@\(user.username)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    
                    UsersStatsView()
                }
                .padding(.horizontal)
                
                ForEach(SideMenuViewModel.allCases, id: \.rawValue) { viewModel in
                    
                    if viewModel == .profile {
                        NavigationLink {
                            ProfileView(user: user)
                        } label: {
                            SideMenuOptionRowView(viewModel: viewModel)
                        }
                    }
                    else if viewModel == .logout {
                        Button {
                            authViewModel.signOut()
                        } label: {
                            SideMenuOptionRowView(viewModel: viewModel)
                        }
                        
                    }
                    else if viewModel == .flappybird {
                        NavigationLink {
                            FlappyBirdView()
                        } label: {
                            SideMenuOptionRowView(viewModel: viewModel)
                        }
                        
                    }
                    else {
                        SideMenuOptionRowView(viewModel: viewModel)
                    }
                    
                }
                Spacer()
            }
            
        }
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView()
    }
}

