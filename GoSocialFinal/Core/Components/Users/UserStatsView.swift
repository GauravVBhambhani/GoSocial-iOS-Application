//
//  UserStatsView.swift
//  GoSocialFinal
//
//  Created by Gaurav Bhambhani on 4/26/23.
//

import SwiftUI

struct UsersStatsView: View {
    var body: some View {
        HStack (spacing: 24) {
            HStack {
                Text("350")
                    .font(.subheadline)
                    .bold()
                
                Text("Following")
                    .font(.caption)
                    .foregroundColor(.gray)
            }

            HStack {
                Text("533")
                    .bold()
                    .font(.subheadline)
                
                Text("Followers")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding(.vertical)
            
        }
    }
}

struct UsersStatsView_Previews: PreviewProvider {
    static var previews: some View {
        UsersStatsView()
    }
}
