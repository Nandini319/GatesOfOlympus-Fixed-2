//
//  GameOverView.swift
//  Gates of Olympus
//
//  Created by Nandini Vithlani on 09/10/23.
//

import SwiftUI

struct GameOverView: View {
    var score: Int
    var restartGame: () -> Void
    
    var body: some View {
        ZStack {
            Spacer()
            Image("GameScene")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                DiamondButton(label: "Game Over")
                DiamondButton(label: "Score: \(score)")
                Button(action: {
                    restartGame()
                }) {
                    DiamondButton(label: "Restart Game")
                }
            }
            .padding()
            
        }
    }
}


