//
//  GuideView.swift
//  Game of Life
//
//  Created by Sadman Adib on 25/8/22.
//

import SwiftUI

struct GuideView: View {
    
    @Binding var showGuide: Bool
    
    var body: some View {
        NavigationView {
            ZStack{
                LinearGradient(colors: [Color.gray, Color(.lightGray)], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
                VStack(spacing: 20){
                    
                    MarkerView(title: "ALIVE", cellColor: .white)
                    
                    MarkerView(title: "DEAD", cellColor: .black)
                    
                    Section {
                        VStack(alignment: .leading){
                            Text("Every cell interacts with its eight neighbours, which are the cells that are horizontally, vertically, or diagonally adjacent")
                                .foregroundColor(.yellow)
                            Divider()
                            Text("1. Any live cell with fewer than two live neighbours dies, as if by underpopulation")
                            Divider()
                            Text("2. Any live cell with two or three live neighbours lives on to the next generation.")
                            Divider()
                            Text("3. Any live cell with more than three live neighbours dies, as if by overpopulation.")
                            Divider()
                            Text("4. Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.")
                        }
                        .foregroundColor(.white)
                        .lineLimit(2)
                        .minimumScaleFactor(0.5)
                    } header: {
                        Text("Rules :")
                            .font(.title3)
                    }

                    
                    Spacer()
                    
                    Text("Tap on the grid cells to set it to either Dead or Alive")
                        .font(.title3)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    Button {
                        showGuide.toggle()
                    } label: {
                        ButtonLabelView(title: "Play Game", color: Color.green)
                    }
                    
                }
                .padding()
            }
            .navigationTitle("Game Guidelines")
        }
    }
}

struct GuideView_Previews: PreviewProvider {
    static var previews: some View {
        GuideView(showGuide: .constant(true))
    }
}

struct MarkerView: View {
    
    var title: String
    var cellColor: Color
    
    var body: some View {
        HStack(spacing: 20){
            Rectangle()
                .frame(width: 50, height: 50)
                .foregroundColor(cellColor)
            
            Text(title)
                .font(.title)
        }
    }
}
