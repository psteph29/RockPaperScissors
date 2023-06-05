//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Paige Stephenson on 6/5/23.
//

import SwiftUI

struct ContentView: View {
    
    let moves = ["✊", "✋", "✌️"]
    @State private var computerChoice = Int.random(in: 0..<3)
    @State private var shouldWin = Bool.random()
    
    @State private var score = 0
    @State private var questionCount = 1
    @State private var showingResults = false
    
    
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(stops: [
                .init(color: Color(red: 0.45,green: 0.81, blue: 0.75), location: 0.45),
                .init(color: Color(red: 0.4, green: 0.9, blue: 0.7), location: 0.45),
            ]), startPoint: .top, endPoint: .bottom).blur(radius: 80.5)
            
      
            
            .ignoresSafeArea()
            VStack {
                Spacer()
                
                Text("Computer has played...")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text(moves[computerChoice])
                    .font(.system(size: 100))
                    .padding(5)
                    
                
                
                if shouldWin {
                    Text("Which one wins?")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                } else {
                    Text("Which one loses")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                HStack {
                    ForEach(0..<3) { number in
                        Button(moves[number]) {
                            playGame(choice: number)
                        }
                    }
                } .padding(10)
                    .font(.system(size: 80))
                
                Spacer()
                
                Text("Score: \(score)")
                    .font(.system(size: 35))
                    .fontWeight(.bold)
                
                Spacer()
            }
       
            
        }
        
        
        
        .alert("Game Over", isPresented: $showingResults) {
            Button("Play Again", action: reset)
        } message: {
            Text("Your score was \(score)")
        }
    }
    
    func playGame(choice: Int) {
        let winningMoves = [1, 2, 0]
        let didWin: Bool
        
        if shouldWin {
            didWin = choice == winningMoves[computerChoice]
        } else {
            didWin = winningMoves[choice] == computerChoice
        }
        if didWin {
            score += 1
        } else if score > 0 {
            score -= 1
        }
        
        if questionCount == 10 {
            showingResults = true
        } else {
            computerChoice = Int.random(in: 0..<3)
            shouldWin.toggle()
            questionCount += 1
        }
        }
    
    func reset() {
        computerChoice = Int.random(in: 0..<3)
        shouldWin = Bool.random()
        questionCount = 0
        score = 0
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
