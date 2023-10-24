//
//  GameView.swift
//  Gates of Olympus
//
//  Created by Nandini Vithlani on 06/10/23.


import SwiftUI
import Combine

struct FallingElement: Identifiable {
    var id = UUID()
    var position: CGPoint
    var isTapped = false
    var color: Color
    var icon: UIImage
    @State private var isGameViewVisible = true
    
    static let colors: [Color] = [.black, .blue, .red, .green]
    static let iconName: [UIImage] = [UIImage(named: "diamond")!,UIImage(named: "crown1")!,UIImage(named: "crown2")!,UIImage(named: "crown3")!,UIImage(named: "crown4")!,UIImage(named: "crown5")!,UIImage(named: "crown6")!,UIImage(named: "crown7")!  ]
    
    static func randomColor() -> Color {
        return colors.randomElement() ?? .black
    }
    
    static func randomIcon() -> UIImage {
        return iconName.randomElement()!
    }
}

struct GameView: View {
    @State private var elements: [FallingElement] = []
    @State private var score = 0
    @State private var lives = 3
    @State private var isGameOver = false
    @State private var isShowingGameOverSheet = false
    var timerInterval: TimeInterval = 2.0
    
    let elementSize: CGFloat = 100
    let maxMissedBalls = 3
    let maxUntappedBalls = 3
    
    @State private var missedBallCount = 0
    @State private var untappedBallCount = 0
    
    @State private var isGameOverViewPresented = false
    @State private var isGameViewVisible = true // Control the visibility of the GameView
    var body: some View {
        if isGameViewVisible {
            NavigationView {
                GeometryReader { geometry in
                    ZStack {
                        Image("mainscreen")
                            .resizable()
                            .scaledToFill()
                            .aspectRatio(contentMode: .fill)
                            .edgesIgnoringSafeArea(.all)
                            .frame(width: geometry.size.width - 100 , height: geometry.size.height)
                            .opacity(0.7)
                        
                        ForEach(elements.indices, id: \.self) { index in
                            if !elements[index].isTapped {
                                Image(uiImage: elements[index].icon)
                                    .resizable()
                                    .frame(width: elementSize, height: elementSize)
                                    .foregroundColor(elements[index].color)
                                    .position(elements[index].position)
                                    .onTapGesture {
                                        withAnimation {
                                            tapElement(at: index)
                                        }
                                    }
                                    .transition(.opacity)
                                    .zIndex(1.0)
                                    .onAppear {
                                        withAnimation(Animation.linear(duration: timerInterval)) {
                                            elements[index].position.y = geometry.size.height
                                        }
                                    }
                                    .onChange(of: elements[index].position, perform: { position in
                                        if elements[index].position.y == geometry.size.height {
                                            if !elements[index].isTapped {
                                                missedBallCount += 1
                                            }
                                            untappedBallCount += 1
                                        }
                                    }
                                    )
                            }
                        }
                        
                        DiamondButton(label: "Score: \(score)")
                            .position(x: geometry.size.width / 2, y: 650)
                            .zIndex(2.0) // Ensure the score text is displayed above falling elements
                    }
                    .onAppear {
                        startGameLoop()
                    }
                }
                .sheet(isPresented: $isGameOverViewPresented) {
                    GameOverView(score: score, restartGame: restartGame)
                }
                .navigationBarTitle("", displayMode: .inline)
            }
        } else {
            // Optional game-over message or other UI when the game is restarted
            Text("Game Restarted")
                .font(.largeTitle)
                .foregroundColor(.white)
        }
    }
    
    func restartGame() {
        score = 0
        lives = 3
        isGameOver = false
        elements.removeAll()
        missedBallCount = 0
        untappedBallCount = 0
        isGameOverViewPresented = false
        startGameLoop()
    }
    
    func startGameLoop() {
        var timer: Timer?
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            guard !isGameOver else {
                timer?.invalidate()
                return
            }
            
            if !isGameOver {
                if missedBallCount < maxMissedBalls || untappedBallCount < maxUntappedBalls {
                    let randomX = CGFloat.random(in: 0...(max(0, UIScreen.main.bounds.width - self.elementSize)))
                    let element = FallingElement(position: CGPoint(x: randomX, y: -self.elementSize / 2), color: FallingElement.randomColor(), icon: FallingElement.randomIcon())
                    
                    DispatchQueue.main.async {
                        elements.append(element)
                    }
                } else {
                    endGame()
                }
            }
        }
        timer?.fire()
    }
    
    func tapElement(at index: Int) {
        if !isGameOver && index < elements.count {
            elements[index].isTapped = true
            score += 1
            untappedBallCount -= 1
        }
    }
    
    func endGame() {
        isGameOver = true
        elements.removeAll()
        isGameOverViewPresented = true
    }
}
