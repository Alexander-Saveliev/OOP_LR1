//
//  LR11_tests.swift
//  LR11_tests
//
//  Created by Marty on 06/02/2018.
//  Copyright © 2018 Marty. All rights reserved.
//

import XCTest

func runAppWithArgy(_ argy: [String]) {
    let programName = "LR11"
    // Create a Task instance
    let task = Process()
    
    // Set the task parameters
    task.launchPath = "/usr/bin/env"
    task.arguments = ["./" + programName] + argy
    
    // Create a Pipe and make the task
    // put all the output there
    let pipe = Pipe()
    task.standardOutput = pipe
    
    // Launch the task
    task.launch()
}

func comparisonFiles(_ file1: String, _ file2: String) -> Bool {
    let dirURL   = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
    let file1URL = dirURL.appendingPathComponent(file1)
    let file2URL = dirURL.appendingPathComponent(file2)
    
    do {
        let text1 = try String(contentsOf: file1URL).components(separatedBy: "\n") as [String]
        let text2 = try String(contentsOf: file2URL).components(separatedBy: "\n") as [String]
        
        return text1 == text2
    } catch {
        print("Failed reading. Error: " + error.localizedDescription)
    }
    return false
}

class LR11_tests: XCTestCase {
    
    func test1() {
        let argy = ["in1.txt", "out1.txt", "some", "trash"]
        runAppWithArgy(argy)
        XCTAssertTrue(comparisonFiles("true_out1.txt", "out1.txt"))
    }
    
    func test2() {
        let argy = ["in2.txt", "out2.txt", "1231234", "trash"]
        runAppWithArgy(argy)
        XCTAssertTrue(comparisonFiles("true_out2.txt", "out2.txt"))
    }
    
    func test3() {
        let argy = ["in3.txt", "out3.txt", "ма", "trash"]
        runAppWithArgy(argy)
        XCTAssertTrue(comparisonFiles("true_out3.txt", "out3.txt"))
    }
    
    func test4() {
        let argy = ["in4.txt", "out4.txt", "so", "#"]
        runAppWithArgy(argy)
        XCTAssertTrue(comparisonFiles("true_out4.txt", "out4.txt"))
    }
    
    func test5() {
        let argy = ["in5.txt", "out5.txt", "а", "#"]
        runAppWithArgy(argy)
        XCTAssertTrue(comparisonFiles("true_out5.txt", "out5.txt"))
    }
}
