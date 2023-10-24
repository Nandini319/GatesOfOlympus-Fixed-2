//
//  ContentView.swift
//  Gates of Olympus
//
//  Created by Nandini Vithlani on 06/10/23.
//
import SwiftUI
import AVFoundation

struct ContentView: View {
    @State private var showGameView = false
    @State private var showGameRules = false
    @State private var isMusicPlaying = false
    @State private var audioPlayer: AVPlayer?
    let maxDuration: TimeInterval = 30.0
    
    let audioUrl = "https://s3.amazonaws.com/kargopolov/kukushka.mp3"
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 40.0/255.0, green: 36.0/255.0, blue: 37.0/255.0)
                    .edgesIgnoringSafeArea(.all)
                Image("GameScene")
                    .resizable()
                    .scaledToFill()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                    NavigationLink(
                        destination: GameView(),
                        isActive: $showGameView
                    ) {
                        DiamondButton(label: "Start Game")
                    }
                    
                    Button(action: {
                        showGameRules.toggle()
                    }) {
                        DiamondButton(label: "Game Rules")
                    }
                    .sheet(isPresented: $showGameRules) {
                        BackgroundView()
                    }
                }
            }
            .navigationBarTitle("") // Hide the default navigation bar title
            .navigationBarItems(trailing: speakerButton) // Place the custom speaker button in the top-right corner
        }
        .onAppear {
            if audioPlayer == nil { // Check if audioPlayer is not already initialized
                playAudio()
            }
            Timer.scheduledTimer(withTimeInterval: maxDuration, repeats: true) { timer in
                restartAudio()
            }
        }
    }
    
    func restartAudio() {
        audioPlayer?.seek(to: .zero) // Use .zero instead of CMTime.zero
        audioPlayer?.play()
    }
    
    func playAudio() {
        guard let url = URL(string: audioUrl) else {
            print("Invalid audio URL")
            return
        }
        
        audioPlayer = AVPlayer(url: url) // Simplify AVPlayer initialization
        audioPlayer?.play()
        isMusicPlaying = true
    }
    
    var speakerButton: some View {
        Button(action: {
            toggleMusic()
        }) {
            Image(systemName: isMusicPlaying ? "speaker.fill" : "speaker.slash.fill")
                .font(.title)
                .foregroundColor(.gold)
        }
    }
    
    func toggleMusic() {
        if isMusicPlaying {
            audioPlayer?.pause()
        } else {
            audioPlayer?.play()
        }
        isMusicPlaying.toggle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
