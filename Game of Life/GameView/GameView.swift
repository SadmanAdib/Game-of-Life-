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
                GridView(vm: vm)
                Section {
                    Picker("Dimension", selection: $vm.dimension) {
                        ForEach(vm.dimensions, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Select a dimension")
                }
                Spacer()
                FunctionButtonsView(vm: vm)
                    .padding(.bottom, 10)
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

struct GridView: View {
    @ObservedObject var vm: GameViewModel
    var body: some View {
        LazyVGrid(columns: vm.columns,
                  spacing: 1) {
            ForEach(vm.range, id: \.self) { i in
                ForEach(vm.range, id: \.self) { j in
                    Rectangle()
                        .id(vm.cellId[i][j])
                        .aspectRatio(contentMode: .fit)
                        .onTapGesture {
                            if vm.grid[i][j] == 1 {
                                vm.grid[i][j] = 0
                            }
                            else {
                                vm.grid[i][j] = 1
                            }
                        }
                        .foregroundColor(vm.grid[i][j] == 1 ? .white : .black)
                }
            }
        }
                  .aspectRatio(1, contentMode: .fill)
                  .padding()
        //For landscaping, the grid becomes smaller, uss the following modifiers instead of the ones in line 89 and 90:
            //      .aspectRatio(1, contentMode: .fit)
    }
}

struct FunctionButtonsView: View {
    
    @ObservedObject var vm: GameViewModel
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    vm.computeLogic()
                } label: {
                    ButtonLabelView(title: "Next Generation", color: Color.red)}
                
                Button {
                    vm.automatePattern()
                } label: {
                    ButtonLabelView(title: vm.isAutomating ? "Stop Automating" : "Automate", color: Color.purple)}
            }
            HStack {
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
}
