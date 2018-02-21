//
//  LR13_tests.swift
//  LR13_tests
//
//  Created by Marty on 18/02/2018.
//  Copyright © 2018 Marty. All rights reserved.
//

import XCTest

func runAppWithargv(_ argv: [String]) -> String {
    let programName = "LR13"
    // Create a Task instance
    let task = Process()
    
    // Set the task parameters
    task.launchPath = "/usr/bin/env"
    task.arguments = ["./" + programName] + argv
    
    // Create a Pipe and make the task
    // put all the output there
    let pipe = Pipe()
    task.standardOutput = pipe
    
    // Launch the task
    task.launch()
    
    // Get the data
    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    let output = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
    
    return output != nil ? output! as String : ""
}

class LR13_tests: XCTestCase {
    
    func test0() {
        XCTAssertEqual(runAppWithargv(["tests/matrix.txt"]), "0.086 -0.063 0.127 0.189 -0.137 -0.034 -0.002 0.092 -0.031 \n")
    }
    
    func test1() {
        XCTAssertEqual(runAppWithargv(["tests/matrix1.txt"]), "0.462 -0.367 0.207 -0.291 0.964 -0.564 -0.047 0.069 -0.029 \n")
    }
    
    func test2() {
        XCTAssertEqual(runAppWithargv(["tests/matrix2.txt"]), "0.048 -0.317 0.079 0.143 0.381 -0.095 -0.286 0.238 0.190 \n")
    }
    
}
