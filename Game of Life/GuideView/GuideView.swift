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
                    
                    HStack(spacing: 20){
                        Rectangle()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.white)
                        
                        Text("ALIVE")
                            .font(.title)
                    }
                    
                    HStack(spacing: 20){
                        Rectangle()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.black)
                        
                        Text("DEAD")
                            .font(.title)
                        
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
                        Text("Continue to Game")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .frame(width: 180, height: 40)
                            .foregroundColor(.white)
                            .background(Color.green)
                            .cornerRadius(10)
                    }
                    
                }
                .padding()
            }
            .navigationTitle("Guidelines")
        }
    }
}

struct GuideView_Previews: PreviewProvider {
    static var previews: some View {
        GuideView(showGuide: .constant(true))
    }
}
