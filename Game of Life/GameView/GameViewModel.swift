//
//  GameViewModel.swift
//  Game of Life
//
//  Created by Sadman Adib on 25/8/22.
//

import SwiftUI

//extension Range: Identifiable {
//    public var id: Int {
//        return Int(UUID().uuidString) ?? 0
//    }
//}

class GameViewModel: ObservableObject {
    
    @Published var grid: [[Int]] = [[]]
    @Published var updatedGrid: [[Int]] = [[]]
    @Published var gridCellColor: Color = .black
    @Published var showGuide = false
    @Published var isAutomating = false
    @Published var columns: [GridItem] = []
    @Published var dimension = 10 {
        didSet {
            populateColumns()
            idGenerator()
        }
    }
    var cellId: [[Int]] = [[]]
    var range: Range<Int> {
        return 0..<dimension
    }
    
    let dimensions = [10, 20, 30, 40, 50]

    init(){
        showGuide.toggle()
        populateColumns()
        idGenerator()
    }

    func idGenerator() {
        var value = 1
        for i in 0..<dimension {
            for j in 0..<dimension {
                self.cellId[i][j] = value
                value += 1
            }
        }
    }
    
    func generateEmptyGrid() {
        grid = Array(repeating: Array(repeating: 0, count: dimension), count: dimension)
        updatedGrid = Array(repeating: Array(repeating: 0, count: dimension), count: dimension)
        cellId = Array(repeating: Array(repeating: 0, count: dimension), count: dimension)
    }
    
    func populateColumns() {
        columns.removeAll()
        for _ in (0..<dimension) {
            columns.append(GridItem(.flexible(minimum: 1), spacing: 1))
        }
        generateEmptyGrid()
    }
    
    func resetGame() {
        grid = Array(repeating: Array(repeating: 0, count: dimension), count: dimension)
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
                
                let col = (x+i+dimension) % dimension
                let row = (y+j+dimension) % dimension
                
                sum += grid[col][row]
            }
        }
        sum -= grid[x][y]
        return sum
    }
    
}
