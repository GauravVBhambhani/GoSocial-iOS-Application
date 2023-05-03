//
//  SideMenuOptionRowView.swift
//  GoSocialFinal
//
//  Created by Gaurav Bhambhani on 4/26/23.
//

import SwiftUI

struct SideMenuOptionRowView: View {
    
    let viewModel: SideMenuViewModel
    
    var body: some View {
        HStack (spacing: 16) {
            Image(systemName: viewModel.imageName)
                .foregroundColor(.gray)
                .font(.headline)
            
            Text(viewModel.description)
                .font(.subheadline)
                .foregroundColor(.black)
                
            
            Spacer()
        }
        .frame(height: 40)
        .padding(.horizontal)
    }
}

struct SideMenuOptionRowView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuOptionRowView(viewModel: .profile)
    }
}
