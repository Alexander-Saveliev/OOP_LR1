//
//  test_LR15.swift
//  test_LR15
//
//  Created by Marty on 12/05/2018.
//  Copyright © 2018 Marty. All rights reserved.
//

import XCTest
import Foundation

func runApp(with argv: [String]) {
    let programName = "LR15"
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

class test_LR15: XCTestCase {
    func testFile1() {
        let argv = ["tests/test1.txt", "tests/testout1.txt"]
        runApp(with: argv)
        
        var outFile = ""
        let outURL  = URL(fileURLWithPath: FileManager.default.currentDirectoryPath + "/\(argv[1])")
        do {
            outFile = try String(contentsOf: outURL, encoding: .utf8)
        } catch {
            print(error)
        }
        
        var answer     = ""
        let answerURL  = URL(fileURLWithPath: FileManager.default.currentDirectoryPath + "/tests/answers/1.txt")
        do {
            answer = try String(contentsOf: answerURL, encoding: .utf8)
        } catch {
            print(error)
        }
        
        XCTAssertEqual(outFile, answer)
    }

    func testFile2() {
        let argv = ["tests/test2.txt", "tests/testout2.txt"]
        runApp(with: argv)
        
        var outFile = ""
        let outURL  = URL(fileURLWithPath: FileManager.default.currentDirectoryPath + "/\(argv[1])")
        do {
            outFile = try String(contentsOf: outURL, encoding: .utf8)
        } catch {
            print(error)
        }
        
        var answer     = ""
        let answerURL  = URL(fileURLWithPath: FileManager.default.currentDirectoryPath + "/tests/answers/2.txt")
        do {
            answer = try String(contentsOf: answerURL, encoding: .utf8)
        } catch {
            print(error)
        }
        
        XCTAssertEqual(outFile, answer)
    }
    
    func testFile3() {
        let argv = ["tests/test3.txt", "tests/testout3.txt"]
        runApp(with: argv)
        
        var outFile = ""
        let outURL  = URL(fileURLWithPath: FileManager.default.currentDirectoryPath + "/\(argv[1])")
        do {
            outFile = try String(contentsOf: outURL, encoding: .utf8)
        } catch {
            print(error)
        }
        
        var answer     = ""
        let answerURL  = URL(fileURLWithPath: FileManager.default.currentDirectoryPath + "/tests/answers/3.txt")
        do {
            answer = try String(contentsOf: answerURL, encoding: .utf8)
        } catch {
            print(error)
        }
        
        XCTAssertEqual(outFile, answer)
    }

    func testFile4() {
        let argv = ["tests/test4.txt", "tests/testout4.txt"]
        runApp(with: argv)
        
        var outFile = ""
        let outURL  = URL(fileURLWithPath: FileManager.default.currentDirectoryPath + "/\(argv[1])")
        do {
            outFile = try String(contentsOf: outURL, encoding: .utf8)
        } catch {
            print(error)
        }
        
        var answer     = ""
        let answerURL  = URL(fileURLWithPath: FileManager.default.currentDirectoryPath + "/tests/answers/4.txt")
        do {
            answer = try String(contentsOf: answerURL, encoding: .utf8)
        } catch {
            print(error)
        }
        
        XCTAssertEqual(outFile, answer)
    }
}
