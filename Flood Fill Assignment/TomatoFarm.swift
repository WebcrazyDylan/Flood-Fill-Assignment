//
//  TomatoFarm.swift
//  Flood Fill Assignment
//
//  Created by Dylan Park on 2021-08-24.
//

import Foundation

func TomatoFarm() {
    struct Square {
        let x: Int
        let y: Int
        let day: Int
    }
    
    let dx = [0, 0, 1, -1]
    let dy = [1, -1, 0, 0]
    
    var tomatoBox = [[Int]]()
    
    let firstLine = readLine()!.split(separator: " ").map { Int($0) }
    let widthM = firstLine[0]!
    let heightN = firstLine[1]!
        
    for _ in 0..<heightN {
        let row: [Int] = readLine()!.split(separator: " ").map { Int($0)! }
        tomatoBox.append(row)
    }
    
    func ripenTomatos(squareArray: [Square]) -> Int {
        let q = Queue<Square>()
        for square in squareArray {
            q.enqueue(item: square)
        }
        var requiredDaysToRipenAll = 0
        
        while !q.isEmpty() {
            // current ripe tomato position
            let sq = q.dequeue()!
            let x = sq.x
            let y = sq.y
            let day = sq.day
            if day > requiredDaysToRipenAll {
                requiredDaysToRipenAll = day
            }
            for i in 0..<4 {
                // tomato position which can be rippen
                let nx = x + dx[i]
                let ny = y + dy[i]
                // check the bounds
                if nx >= 0 && nx < widthM && ny >= 0 && ny < heightN {
                    if tomatoBox[ny][nx] == 0 {
                        q.enqueue(item: Square(x: nx, y: ny, day: day + 1))
                        tomatoBox[ny][nx] = 1
                    }
                }
            }
        }
        return requiredDaysToRipenAll
    }
    
    var originalRipeTomatos: [Square] = []
    for y in 0..<heightN {
        for x in 0..<widthM {
            if tomatoBox[y][x] == 1 {
                originalRipeTomatos.append(Square(x: x, y: y, day: 0))
            }
        }
    }
    
    let days = ripenTomatos(squareArray: originalRipeTomatos)
    
    func checkAllRippend() -> Bool {
        for y in 0..<heightN {
            for x in 0..<widthM {
                if tomatoBox[y][x] == 0 {
                    return false
                }
            }
        }
        return true
    }
    
    if checkAllRippend() {
        print(days)
    } else {
        print(-1)
    }
}
