//
//  GameRulesView.swift
//  Gates of Olympus
//
//  Created by Nandini Vithlani on 06/10/23.
//
import SwiftUI

struct GameRulesView: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image("mainscreen")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)

                
                VStack(spacing: 20) {
                    Text("Game Rules")
                        .font(.custom("Georgia", size: 40))
                        .foregroundColor(.black)
                    
                    Text("1. Tap to pop items")
                        .font(.custom("Georgia", size: 17))
                        .foregroundColor(.black)
                    
                    Text("2. Don’t let them reach the line")
                        .font(.custom("Georgia", size: 17))
                        .foregroundColor(.black)
                    
                    Text("3. You have 3 lives")
                        .font(.custom("Georgia", size: 17))
                        .foregroundColor(.black)
                    
                    Text("4. Try to get the BEST SCORE")
                        .font(.custom("Georgia", size: 17))
                        .foregroundColor(.black)
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .background(
                    Image("rules background") // Replace with your background image name
                        .resizable()
                        .scaledToFill()
                        .frame(height: geometry.size.height / 2) // Set the height to half of the screen
                )
            }
        }
    }
}



struct BackgroundView: View {
    var body: some View {
        Image("rules background") // Replace "backgroundImage" with the name of your background image
            .resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea(.all)
            .overlay(
                GameRulesView()
            )
    }
}


