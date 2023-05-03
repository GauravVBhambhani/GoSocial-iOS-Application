//
//  NewThoughtView.swift
//  GoSocialFinal
//
//  Created by Gaurav Bhambhani on 4/26/23.
//

import SwiftUI
import Kingfisher


struct NewThoughtView: View {
    
    @State private var newThought = ""
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var authViewModel: AuthViewModel
    @ObservedObject var viewModel = UploadThoughtViewModel()
    
    var body: some View {
        
        VStack {
            HStack {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Cancel")
                        .foregroundColor(Color(.systemBlue))
                }
                
                Spacer()
                
                Button {
//                    print("Post")
                    viewModel.uploadThought(withCaption: newThought)
                } label: {
                    Text("Post")
                        .bold()
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(Color(.systemBlue))
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                }
            }
            .padding()
            
            HStack(alignment: .top) {
                
                if let user = authViewModel.currentUser {
                    KFImage(URL(string: user.dpImageUrl))
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 64, height: 64)
                }
                
                TextArea("What's on your mind?", text: $newThought)
            }
            .padding()
        }
        .onReceive(viewModel.$didUploadThought) { success in
            if success {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct NewThoughtView_Previews: PreviewProvider {
    static var previews: some View {
        NewThoughtView()
    }
}
