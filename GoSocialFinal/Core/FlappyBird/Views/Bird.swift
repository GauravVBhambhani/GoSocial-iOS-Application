//
//  Bird.swift
//  GoSocialFinal
//
//  Created by Gaurav Bhambhani on 4/28/23.
//

import SwiftUI

struct Bird: View {
    
    let rows = 5
    let cols = 5
    let size: CGFloat = 10

    let birdBlocks: [[Color]] = [
        [.clear, .clear, .red, .red, .clear],
        [.clear, .red, .red, .white, .clear],
        [.white, .white, .red, .orange, .orange],
        [.red, .white, .white, .red, .red],
        [.clear, .red, .red, .red, .clear]
    ]

    var body: some View {
        VStack(spacing: 0) {
            ForEach((0...self.rows - 1), id: \.self) { row in
                HStack(spacing: 0) {
                    ForEach((0...self.cols - 1), id: \.self) { col in
                        VStack(spacing: 0) {
//                            Rectangle()
//                                .frame(width: self.size, height: self.size)
//                                .foregroundColor(self.copterBlocks[row][col])
                            Pixels(size: self.size, color: self.birdBlocks[row][col])
                        }
                    }
                }
            }
        }
    }
}

//struct Bird_Previews: PreviewProvider {
//    static var previews: some View {
//        Bird()
//    }
//}

