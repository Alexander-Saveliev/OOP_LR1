//
//  main.swift
//  LR15
//
//  Created by Marty on 12/05/2018.
//  Copyright © 2018 Marty. All rights reserved.
//

import Foundation



func main() {
    guard CommandLine.arguments.count == 3 else {
        print("Incorrect number of arguments")
        print("Try this: ./LR15 <input file> <output file>")
        return
    }
    
    let inputFileName  = CommandLine.arguments[1]
    let outputFileName = CommandLine.arguments[2]
    
    guard let lines = readLinesFromFile(inputFileName) else {
        print("Incorrect input file")
        return
    }
    
    var (field, startPoints) = transformLinesIntoArray(lines)
    
    for startPoint in startPoints {
        fillField(&field, fromPoint: startPoint)
    }

    writeIntoFile(outputFileName, value: transformArrayIntoLine(field))
}




main()


