//
//  LR11_tests.swift
//  LR11_tests
//
//  Created by Marty on 06/02/2018.
//  Copyright © 2018 Marty. All rights reserved.
//

import XCTest

func runAppWithargv(_ argv: [String]) {
    let programName = "LR11"
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
    sleep(10)
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
        print("Failed reading in comperison. Error: " + error.localizedDescription)
    }
    return false
}

class LR11_tests: XCTestCase {
    
    func test1() {
        let argv = ["tests/in1.txt", "tests/out1.txt", "some", "trash"]
        runAppWithargv(argv)
        XCTAssertTrue(comparisonFiles("tests/true_out1.txt", "tests/out1.txt"))
    }
    
    func test2() {
        let argv = ["tests/in2.txt", "tests/out2.txt", "1231234", "trash"]
        runAppWithargv(argv)
        XCTAssertTrue(comparisonFiles("tests/true_out2.txt", "tests/out2.txt"))
    }
    
    func test3() {
        let argv = ["tests/in3.txt", "tests/out3.txt", "ма", "trash"]
        runAppWithargv(argv)
        XCTAssertTrue(comparisonFiles("tests/true_out3.txt", "tests/out3.txt"))
    }
    
    func test4() {
        let argv = ["tests/in4.txt", "tests/out4.txt", "so", "#"]
        runAppWithargv(argv)
        XCTAssertTrue(comparisonFiles("tests/true_out4.txt", "tests/out4.txt"))
    }
    
    func test5() {
        let argv = ["tests/in5.txt", "tests/out5.txt", "а", "#"]
        runAppWithargv(argv)
        XCTAssertTrue(comparisonFiles("tests/true_out5.txt", "tests/out5.txt"))
    }
}
