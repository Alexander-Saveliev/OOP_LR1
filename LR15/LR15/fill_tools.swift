//
//  fill_tools.swift
//  LR15
//
//  Created by Marty on 12/05/2018.
//  Copyright © 2018 Marty. All rights reserved.
//

import Foundation

func readLinesFromFile(_ fileNane: String) -> [String]? {
    let fileURL  = URL(fileURLWithPath: FileManager.default.currentDirectoryPath + "/\(fileNane)")
    var lines: [String]
    let bound = 100
    
    do {
        lines = try String(contentsOf: fileURL, encoding: .utf8).components(separatedBy: "\n")
    } catch {
        print("Error: ", error)
        return nil
    }
    
    if lines.count > bound {
        lines = Array(lines[..<bound])
    }
    
    let lineLength = lines[0].count < bound ? lines[0].count : bound
    
    for (i, line) in lines.enumerated() {
        if line.count > bound {
            lines[i] = String(lines[i].prefix(upTo: line.index(line.startIndex, offsetBy: bound)))
        }
        
        if line.count != lineLength {
            return nil
        }
    }
    
    return lines
}

func writeIntoFile(_ fileName: String, value: String) {
    let fileURL  = URL(fileURLWithPath: FileManager.default.currentDirectoryPath + "/\(fileName)")
    
    do {
        try value.write(to: fileURL, atomically: false, encoding: .utf8)
    } catch {
        print("Error with writing", error)
        return
    }
}

func transformLinesIntoArray(_ lines: [String]) -> (array: [[Cell]], startPoints: [Point]) {
    let borderLine = Array(repeating: Cell.border, count: lines[0].count + 2)
    
    var array = [borderLine]
    var startPoints = [Point]()
    
    for (y, line) in lines.enumerated() {
        var arrLine = [Cell.border]
        
        for (x, char) in line.enumerated() {
            switch char {
            case "#":
                arrLine.append(.border)
            case "O":
                arrLine.append(.start)
                startPoints.append(Point(y: y + 1, x: x + 1))
            default:
                arrLine.append(.empty)
            }
        }
        arrLine.append(.border)
        array.append(arrLine)
    }
    
    array.append(borderLine)
    
    return (array, startPoints)
}

func fillField(_ field: inout [[Cell]], fromPoint point: Point) {
    var someKindOfQueue = [point]
    
    while !someKindOfQueue.isEmpty {
        let current = someKindOfQueue.removeFirst()
        
        if field[current.y][current.x] == .start || field[current.y][current.x] == .empty {
            someKindOfQueue.append(Point(y: current.y + 1, x: current.x))
            someKindOfQueue.append(Point(y: current.y - 1, x: current.x))
            someKindOfQueue.append(Point(y: current.y, x: current.x + 1))
            someKindOfQueue.append(Point(y: current.y, x: current.x - 1))
            
            if field[current.y][current.x] != .start {
                field[current.y][current.x] = .filled
            }
        }
    }
}

func transformArrayIntoLine(_ field: [[Cell]]) -> String {
    var output = ""
    
    for (i, arrLine) in field.enumerated() where i != 0 && i != field.count - 1 {
        var line = ""
        
        for (i, cell) in arrLine.enumerated() where i != 0 && i != arrLine.count - 1 {
            switch cell {
            case .border:
                line.append("#")
            case .empty:
                line.append(" ")
            case .filled:
                line.append(".")
            case .start:
                line.append("O")
            }
        }
        line.append("\n")
        output.append(line)
    }
    
    return output
}
