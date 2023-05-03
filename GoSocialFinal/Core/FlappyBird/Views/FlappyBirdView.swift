//
//  GameView.swift
//  GoSocialFinal
//
//  Created by Gaurav Bhambhani on 4/28/23.
//

import SwiftUI

struct FlappyBirdView: View {
    
    @State private var copterPosition = CGPoint(x:100, y:100)
    @State private var obsPosition = CGPoint(x:1000, y:300)
    
    @State private var isPaused = false
    
    @State var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    @State private var score = 0
    
    var body: some View {
        
        GeometryReader { geo in
            
            
            ZStack {
                Bird()
                    .position(self.copterPosition)
                    .onReceive(timer) { _ in
                        self.gravity()
                    }
                
                Obstacle()
                    .position(self.obsPosition)
                    .onReceive(self.timer) { _ in
                        self.obsMove()
                        
                    }
                
                Text("Score: \(self.score)")
                    .foregroundColor(.white)
                    .position(x: geo.size.width - 100, y: geo.size.height / 10)
                
              
                self.isPaused ? Button("Restart") {self.resume()} : nil
                
                

            }
            .edgesIgnoringSafeArea(.all)
            .frame(width: geo.size.width, height: geo.size.height)
            .background(Color.blue)
            .foregroundColor(.white)
            
            .gesture(
                TapGesture()
                    .onEnded{
                        withAnimation {
                            self.copterPosition.y -= 100
                        }
                    }
            )
            .onReceive(self.timer) {_ in
                self.physics()
                self.score += 1
            }
        }
        .edgesIgnoringSafeArea(.all)
        
    }
    
    func gravity() {
        withAnimation {
            self.copterPosition.y += 20
        }
        
    }
    
    func obsMove() {
        if self.obsPosition.x > 0 {
            withAnimation {
                self.obsPosition.x -= 20

            }
        }
        else {
            self.obsPosition.x = 1000
            self.obsPosition.y = CGFloat.random(in: 0...500)
        }
    }
    
    func pause() {
        self.timer.upstream.connect().cancel()
    }
    
    func resume() {
        self.timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
        
        self.obsPosition.x = 1000
        self.copterPosition = CGPoint(x:100, y:100)
        self.isPaused = false
        self.score = 0
    }
    
    //for collision detection
    func physics() {
        
        if abs(copterPosition.x - obsPosition.x) < (25 + 10) && abs(copterPosition.y - obsPosition.y) < (25 + 100) {
            self.pause()
            self.isPaused = true
        }
    }
    
}

struct FlappyBirdView_Previews: PreviewProvider {
    static var previews: some View {
        FlappyBirdView()
    }
}


