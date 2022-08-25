//
//  GameView.swift
//  Game of Life
//
//  Created by Sadman Adib on 24/8/22.
//

import SwiftUI

struct GameView: View {
    
    @StateObject var vm = GameViewModel()
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color.gray, Color(.lightGray)], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            VStack {
                Spacer()
                Spacer()
                HStack {
                    Spacer()
                    LazyVGrid(columns: vm.columns,
                              spacing: 2) {
                        ForEach(0..<10) { i in
                            ForEach(0..<10) { j in
                                Rectangle()
                                    .frame(width: 30, height: UIScreen.main.bounds.height / 30)
                                    .onTapGesture {
                                        vm.switchNumber.toggle()
                                        if vm.switchNumber {
                                            vm.grid[i][j] = 1
                                        }
                                        else {
                                            vm.grid[i][j] = 0
                                        }
                                    }
                                    .foregroundColor(vm.grid[i][j] == 1 ? .white : .black)
                            }
                        }
                    }
                    Spacer()
                }
                
                Spacer()
                
                ScrollView(.horizontal){
                    HStack {
                        Button {
                            vm.computeLogic()
                        } label: {
                            ButtonLabelView(title: "Next Generation", color: Color.red)}
                        
                        Button {
                            vm.automatePattern()
                        } label: {
                            ButtonLabelView(title: vm.isAutomating ? "Stop Automating" : "Automate", color: Color.purple)}
                        
                        Button {
                            vm.populatingGridRandomly()
                        } label: {
                            ButtonLabelView(title: "Random Start", color: Color.green)}
                        
                        Button {
                            vm.resetGame()
                        } label: {
                            ButtonLabelView(title: "Reset", color: Color.blue)}
                    }
                }
            }
            .padding()
        }
        .fullScreenCover(isPresented: $vm.showGuide) {
            GuideView(showGuide: $vm.showGuide)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}

struct ButtonLabelView: View {
    
    var title: String
    var color: Color
    
    var body: some View {
        Text(title)
            .font(.title3)
            .fontWeight(.semibold)
            .frame(width: 160, height: 35)
            .foregroundColor(.white)
            .background(color)
            .cornerRadius(10)
    }
}
