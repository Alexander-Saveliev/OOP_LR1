//
//  some_lib.swift
//  LR13
//
//  Created by Marty on 18/02/2018.
//  Copyright © 2018 Marty. All rights reserved.
//

func getArgv() -> [String] {
    assert(CommandLine.arguments.count == 2, "Incorrect number of arguments. It must be 1")
    
    let argv = CommandLine.arguments
    
    return argv
}


func getMatrixFromString(_ str: String) -> [[Double]] {
    let matrixSize = 3
    
    var matrix = Array(repeatElement(Array(repeatElement(0.0, count: matrixSize)), count: matrixSize))
    
    for (y, row) in str.components(separatedBy: "\n").enumerated() where row != "" {
        for (x, element) in row.components(separatedBy: "\t").enumerated() {
            assert(x < matrixSize && y < matrixSize, "Incorrect number of element in matrix")
            if let toDouble = Double(element) {
                matrix[y][x] = toDouble
            } else {
                assertionFailure("Incorrect element in matrix. Position: \(y) \(x)")
            }
        }
    }
    
    return matrix
}


func printElementsOfMatrix(_ matrix: [[Double]]) {
    for row in matrix {
        for element in row {
            print(String(format: "%.03f", element), terminator: " ")
        }
        print()
    }
    print()
}


func checkMatrixDimention(_ matrix: [[Double]]) {
    assert(matrix.count == 3, "Incorrect matrix")
    
    for line in matrix {
        assert(line.count == 3, "Incorrect matrix")
    }
}


func findDeterminant(_ matrix: [[Double]]) -> Double {
    
/*
     
          | a1 b1 c1 |
     M =  | a2 b2 c2 |
          | a3 b3 c3 |
     
     
     determinant[M] = (a1 * b2 * c3) + (a2 * b3 * c1) + (a3 * b1 * c2) -
                      (a3 * b2 * c1) - (a2 * b1 * c3) - (a1 * b3 * c2)
     
     I call (...) as diagonal
     
 */
    
    var determinant = 0.0
    
    checkMatrixDimention(matrix)
    
    for i in 0..<matrix.count {
        var reversDiagonal = 1.0
        var diagonal       = 1.0
        
        for j in 0..<matrix.count {
            reversDiagonal *= matrix[j][(i - j + matrix.count - 1) % matrix.count]
            diagonal       *= matrix[j][(i + j) % matrix.count]
        }
        
        determinant += (diagonal - reversDiagonal)
    }
    
    return determinant
}


func getAlgebraicComplementsForMatrix(_ matrix: [[Double]]) -> [[Double]] {
    checkMatrixDimention(matrix)
    
    var minor = Array(repeatElement(Array(repeatElement(0.0, count: 3)), count: 3))
    
    for y in 0..<matrix.count {
        for x in 0..<matrix.count {
            minor[y][x] = matrix[(y + 1) % matrix.count][(x + 1) % matrix.count] *
                          matrix[(y + 2) % matrix.count][(x + 2) % matrix.count] -
                          matrix[(y + 2) % matrix.count][(x + 1) % matrix.count] *
                          matrix[(y + 1) % matrix.count][(x + 2) % matrix.count]
        }
    }

    return minor
    
}


func transposeMatrix(_ matrix: inout [[Double]]) {
    checkMatrixDimention(matrix)
    
    for y in 0..<matrix.count {
        for x in y + 1..<matrix.count {
            (matrix[y][x], matrix[x][y]) = (matrix[x][y], matrix[y][x])
        }
    }
}


func divideMatrix(_ matrix: inout [[Double]], by divider: Double) {
    checkMatrixDimention(matrix)
    assert(divider != 0, "Division by 0")
    
    for y in 0..<matrix.count {
        for x in 0..<matrix.count {
            matrix[y][x] /= divider
        }
    }
}


func invertMatrix(_ matrix: inout [[Double]]){
    let accuracy = 0.0005
    checkMatrixDimention(matrix)
    
    let determinant = findDeterminant(matrix)
    
    
    assert(determinant > accuracy, "Determinant = 0!")

    
    var algebraicComplements = getAlgebraicComplementsForMatrix(matrix)
    transposeMatrix(&algebraicComplements)
    
    divideMatrix(&algebraicComplements, by: determinant)
    
    matrix = algebraicComplements
}
