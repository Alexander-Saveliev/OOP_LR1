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

    
//reading
do {
    let input = try String(contentsOf: fileURL, encoding: .utf8)
    
    var matrix: [[Double]]! = getMatrixFromString(input)
    invertMatrix(&matrix)
    
    if (matrix == nil) {
        print("Reversed matrix doesn't exist")
    } else {
        printElementsOfMatrix(matrix)
    }
    
    
}
catch {/* error handling here */}



