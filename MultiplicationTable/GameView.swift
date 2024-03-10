//
//  GameView.swift
//  MultiplicationTable
//
//  Created by enesozmus on 10.03.2024.
//

import SwiftUI

struct GameView: View {
    
    @Binding var game: Game
    
    @State private var animationAmount = 0.0
    @State private var scaleAnimation = 0.0
    
    @Environment(\.dismiss) var dismiss
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        // ZStack start
        ZStack {
            // Asset -> Set Custom Color
            Color("CustomColor")
                .ignoresSafeArea()
            
            // VStack start
            VStack {
                Spacer()
                Spacer()
                
                Text("\(game._multiplicationTable) x \(game._currentQuestion) = ?")
                    .font(.title)
                    .frame(width: 170, height: 90)
                    .background(.white)
                    .cornerRadius(10)
                    .shadow(color: .black, radius: 2, x: 2, y: 2)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(.black, lineWidth: 1)
                    )
                    .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
                
                Spacer()
                
                Image(systemName: game._isRight ? "checkmark" : "xmark")
                    .font(.system(size: 70))
                    .frame(width: 100, height: 100)
                    .background(game._isRight ? .green : .red)
                    .foregroundColor(.black)
                    .cornerRadius(10)
                    .shadow(color: .black, radius: 2, x: 2, y: 2)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(.black, lineWidth: 1)
                    )
                    .scaleEffect(scaleAnimation)
                    .animation(.easeInOut.speed(0.44), value: scaleAnimation)
                
                Spacer()
                
                LazyVGrid(columns: columns, spacing: 25) {
                    ForEach(0..<15) { number in
                        Button {
                            game.checkAnswer(btnNumber: number)
                            withAnimation {
                                animationAmount += 360
                                scaleAnimation += 4
                            }
                            scaleAnimation -= 4
                        } label: {
                            Text(String(game._answers[number]))
                                .font(.title2)
                                .foregroundColor(.black)
                                .frame(width: 45, height: 45, alignment: .center)
                                .padding()
                                .overlay(
                                    Circle()
                                        .stroke(Color.orange, lineWidth: 3.5)
                                        .padding(6)
                                )
                                .background(.white)
                                .cornerRadius(125)
                        }
                    }
                }
                .frame(maxWidth: 250)
                
                
                Spacer()
                
                
                Text("\(game._round)/\(game._numberOfQuestions)")
                    .font(.system(size: 36, weight: .heavy, design: .rounded))
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            }
            // VStack end
        }
        // ZStack end
        .onAppear {
            game.start()
        }
        .alert("Your score is:", isPresented: $game._showingScore) {
            Button("Play again!") {
                dismiss()
            }
        } message: {
            Text("\(game._score)/\(game._numberOfQuestions)")
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    // body end
}

struct GameView_Previews: PreviewProvider {
    static private var game = Binding.constant(Game())
    
    static var previews: some View {
        GameView(game: game)
            .previewInterfaceOrientation(.portrait)
    }
}

