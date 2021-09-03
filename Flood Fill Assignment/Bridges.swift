//
//  Bridges.swift
//  Flood Fill Assignment
//
//  Created by Dylan Park on 2021-08-24.
//

import Foundation

func Bridges() {
    struct Square {
        let x: Int
        let y: Int
        let length: Int
    }
    
    let dx = [0, 0, 1, -1]
    let dy = [1, -1, 0, 0]
    
    let N = Int(readLine()!)!
    
    var finalBridgeLength = 2 * N
    
    var map = [[Int]]()
    var coloredMap = [[Int]](repeating: [Int](repeating: 0, count: N), count: N)
    
    for _ in 0..<N {
        let row: [Int] = readLine()!.split(separator: " ").map { Int($0)! }
        map.append(row)
    }
    
    func createColoredMap(square: Square, id: Int) {
        let q = Queue<Square>()
        q.enqueue(item: square)
        coloredMap[square.y][square.x] = id
        
        while !q.isEmpty() {
            let sq = q.dequeue()!
            let x = sq.x
            let y = sq.y
            let length = sq.length
            for i in 0..<4 {
                let nx = x + dx[i]
                let ny = y + dy[i]
                // check the bounds
                if nx >= 0 && nx < N && ny >= 0 && ny < N {
                    if (map[ny][nx] == 1 && coloredMap[ny][nx] == 0) {
                        q.enqueue(item: Square(x: nx, y: ny, length: length))
                        coloredMap[ny][nx] = id
                    }
                }
            }
        }
    }
    
    var id = 0
    for y in 0..<N {
        for x in 0..<N {
            if map[y][x] == 1 && coloredMap[y][x] == 0 {
                id += 1
                createColoredMap(square: Square(x: x, y: y, length: 0), id: id)
            }
        }
    }
    
    func bridgeLength(square: Square) {
        let q = Queue<Square>()
        q.enqueue(item: square)
        let islandID = coloredMap[square.y][square.x]
        
        var shortestLength = 2 * N
        
        while !q.isEmpty() {
            var duplicatedColoredMap = [[Int]](repeating: [Int](repeating: 0, count: N), count: N)
            for y in 0..<coloredMap.count {
                for x in 0..<coloredMap[y].count {
                    duplicatedColoredMap[y][x] = coloredMap[y][x]
                }
            }
            let sq = q.dequeue()!
            let x = sq.x
            let y = sq.y
            let length = sq.length
            if length > finalBridgeLength {
                break
            }
            
            for i in 0..<4 {
                let nx = x + dx[i]
                let ny = y + dy[i]
                // check the bounds
                if nx >= 0 && nx < N && ny >= 0 && ny < N {
                    if duplicatedColoredMap[ny][nx] == 0 {
                        q.enqueue(item: Square(x: nx, y: ny, length: length + 1))
                        duplicatedColoredMap[ny][nx] = -1
                    } else if duplicatedColoredMap[ny][nx] == -1 {
                       continue
                    } else if duplicatedColoredMap[ny][nx] != islandID {
                        if length < shortestLength {
                            shortestLength = length
                        }
                        if shortestLength < finalBridgeLength {
                            finalBridgeLength = shortestLength
                        }
                        break
                    } else if duplicatedColoredMap[ny][nx] == islandID{
                        continue
                    }
                }
            }
        }
    }
    
    for y in 0..<N {
        for x in 0..<N {
            if coloredMap[y][x] != 0 {
                bridgeLength(square: Square(x: x, y: y, length: 0))
            }
        }
    }
    print(finalBridgeLength)
}
