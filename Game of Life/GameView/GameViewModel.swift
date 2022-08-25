//
//  GameViewModel.swift
//  Game of Life
//
//  Created by Sadman Adib on 25/8/22.
//

import SwiftUI

class GameViewModel: ObservableObject {
    
    @Published var grid: [[Int]] = Array(repeating: Array(repeating: 0, count: 10), count: 10)
    @Published var updatedGrid: [[Int]] = Array(repeating: Array(repeating: 0, count: 10), count: 10)
    @Published var gridCellColor: Color = .black
    @Published var showGuide = false
    @Published var isAutomating = false
    @Published var columns: [GridItem] = []
    
    init(){
        showGuide.toggle()
        populateColumns()
    }
    
    func populateColumns() {
        for _ in (0..<10) {
            columns.append(GridItem(.flexible(), spacing: 1))
        }
    }
    
    func resetGame() {
        grid = Array(repeating: Array(repeating: 0, count: 10), count: 10)
    }
    
    func populatingGridRandomly() {
        for i in grid.indices {
            for j in grid.indices {
                self.grid[i][j] = Int.random(in: 0...1)
            }
        }
    }
    
    func computeLogic() {
        for i in grid.indices {
            for j in grid.indices {
                let state = grid[i][j]
                //count live neighbors
                let neighbors = countNeighbors(grid: grid, x: i, y: j)
                //rules
                if (state == 0 && neighbors == 3 ) {
                    updatedGrid[i][j] = 1
                }else if (state == 1 && (neighbors < 2 || neighbors > 3)) {
                    updatedGrid[i][j] = 0
                }else {
                    updatedGrid[i][j] = state
                }
            }
        }
        grid = updatedGrid
        if isAutomating {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.computeLogic()
            }
        }
    }
    
    func automatePattern() {
        isAutomating.toggle()
        computeLogic()
    }
    
    func countNeighbors(grid: [[Int]], x: Int, y: Int) -> Int {
        var sum = 0
        for i in (-1...1) {
            for j in (-1...1) {
                
                let col = (x+i+10) % 10
                let row = (y+j+10) % 10
                
                sum += grid[col][row]
            }
        }
        sum -= grid[x][y]
        return sum
    }
    
}
