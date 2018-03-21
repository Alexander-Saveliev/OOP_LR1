//
//  main.swift
//  LR13
//
//  Created by Marty on 18/02/2018.
//  Copyright © 2018 Marty. All rights reserved.
//

import Foundation

let argv = getArgv()


let fileURL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath + "/\(argv[1])")

typealias matrix = [[Double]]!
    
//reading
do {
    let input = try String(contentsOf: fileURL, encoding: .utf8)
    
    let matrix: matrix = getMatrixFromString(input)
    
    
    let reversedMatrix = invertMatrix(matrix)
    
    if (reversedMatrix == nil) {
        print("Reversed matrix doesn't exist")
    } else {
        printElementsOfMatrix(reversedMatrix!)
    }
    
    
}
catch {/* error handling here */}



