//
//  Obstacle.swift
//  GoSocialFinal
//
//  Created by Gaurav Bhambhani on 4/28/23.
//

import SwiftUI

struct Obstacle: View {
    
    let width: CGFloat = 20
    let height: CGFloat = 200
    
    var body: some View {
        Rectangle()
            .frame(width: width, height: height)
            .foregroundColor(Color(.red))
    }
}

struct Obstacle_Previews: PreviewProvider {
    static var previews: some View {
        Obstacle()
    }
}
