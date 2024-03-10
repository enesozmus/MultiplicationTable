//
//  ContentView.swift
//  MultiplicationTable
//
//  Created by enesozmus on 10.03.2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var game = Game()
    
    
    var body: some View {
        NavigationView {
            // ZStack start
            ZStack {
                // Asset -> Set Custom Color
                Color("CustomColor")
                    .ignoresSafeArea()
                
                
                // VStack start
                VStack(spacing: 35) {
                    Spacer()
                    Spacer()
                    
                    Text("Multiplication Table")
                        .font(.title.bold())
                        .kerning(1)
                        .padding(.bottom, 30)
                    
                    
                    HStack {
                        Text("Multiple of")
                            .frame(width: 85, height: 85, alignment: .center)
                            .padding()
                            .overlay(
                                Circle()
                                    .stroke(Color.orange, lineWidth: 4)
                                    .padding(6)
                            )
                            .background(.white)
                        
                        Picker("Select multiplication table", selection: $game._multiplicationTable) {
                            ForEach(1..<20, id: \.self) {
                                Text("\($0)")
                            }
                        }
                        .accentColor(.black)
                        .frame(width: 62, height: 62)
                        .overlay(Rectangle() .strokeBorder(.gray, lineWidth: 2))
                    }
                    .background(.white)
                    .cornerRadius(10)
                    .shadow(color: .black, radius: 2, x: 2, y: 2)
                    .overlay(RoundedRectangle(cornerRadius: 10) .strokeBorder(.black, lineWidth: 1))
                    
                    
                    HStack {
                        Text("Number of questions")
                            .frame(width: 85, height: 85, alignment: .center)
                            .padding()
                            .overlay(
                                Circle()
                                    .stroke(Color.orange, lineWidth: 4)
                                    .padding(6)
                            )
                            .background(.white)
                        
                        Picker("Select difficulty", selection: $game._numberOfQuestions) {
                            ForEach(game._chooseQuestions, id: \.self) {
                                Text("\($0)")
                            }
                        }
                        .accentColor(.black)
                        .frame(width: 62, height: 62)
                        .overlay(Rectangle() .strokeBorder(.gray, lineWidth: 2))
                    }
                    .background(.white)
                    .cornerRadius(10)
                    .shadow(color: .black, radius: 2, x: 2, y: 2)
                    .overlay(RoundedRectangle(cornerRadius: 10) .strokeBorder(.black, lineWidth: 1))
                    
                    
                    Spacer()
                    
                    
                    NavigationLink {
                        GameView(game: $game)
                    } label: {
                        Text("Play!")
                            .font(.title)
                            .foregroundColor(.black)
                            .padding(25)
                            .padding(.horizontal)
                            .background(.white)
                            .cornerRadius(10)
                            .shadow(color: .black, radius: 2, x: 2, y: 2)
                            .overlay(RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(.black, lineWidth: 1)
                            )
                    }
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                }
                .labelsHidden()
                // VStack end
            }
            // ZStack end
        }
        // NavigationView end
    }
    // body end
}


#Preview {
    ContentView()
}
