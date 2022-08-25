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
                .frame(width: 80, height: 80)
                .foregroundColor(cellColor)
            
            Text(title)
                .font(.title)
        }
    }
}
