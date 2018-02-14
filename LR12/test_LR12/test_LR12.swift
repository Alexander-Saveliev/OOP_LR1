//
//  test_LR12.swift
//  test_LR12
//
//  Created by Marty on 11/02/2018.
//  Copyright © 2018 Marty. All rights reserved.
//

import XCTest

func runAppWithArgy(_ argy: [String]) {
    let programName = "LR12"
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
    sleep(10)
}


func getArgy() -> [String] {
    assert(CommandLine.arguments.count == 4, "Incorrect number of arguments. It must be 3")
    
    let argy = CommandLine.arguments
    
    return argy
}


func checkNotation(_ notation: Int, withValue value: String) -> Bool {
    guard notation >= 2 && notation <= 36 else {
        return false
    }
    
    let notationAlphabet = "0123456789ABCDEFGHIGKLMNOPQRSTUVWXYZ"
    
    // Creation notation set with current notation
    var currentNotation = Set<Character>()
    
    for (i, char) in notationAlphabet.enumerated() where i < notation {
        currentNotation.insert(char)
    }
    
    // Checking elements of value
    for (i, char) in value.enumerated() where !currentNotation.contains(char) {
        if i == 0 && char == "-" {
            continue
        }
        return false
    }
    
    return true
}

func getCharByNumber (_ value: Int) -> Character? {
    let notationAlphabet = "0123456789ABCDEFGHIGKLMNOPQRSTUVWXYZ"
    
    return value < 0 || value > 35 ? nil : notationAlphabet[notationAlphabet.index(notationAlphabet.startIndex, offsetBy: value)]
}


func getNumberOfChar(_ value: Character) -> Int? {
    let notationAlphabet = "0123456789ABCDEFGHIGKLMNOPQRSTUVWXYZ"
    
    for (i, char) in notationAlphabet.enumerated() where char == value {
        return i
    }
    
    return nil
}


func convertValue(_ str: String, fromNotation from: Int, toNotation to: Int) -> String {
    let minusSign: Character = "-"
    var value = str
    
    let minus = value.count > 0 && value[value.startIndex] == minusSign
    
    if minus {
        value.remove(at: value.startIndex)
    }
    
    
    // Calculating into decimal
    var decimalResult = 0
    
    for (i, digit) in value.reversed().enumerated() {
        decimalResult += getNumberOfChar(digit)! * Int(pow(Double(from), Double(i)))
    }
    
    // From decimal
    var answer = ""
    
    answer.insert(getCharByNumber(decimalResult % to)!, at: answer.startIndex)
    
    while decimalResult / to != 0 {
        decimalResult /= to
        answer.insert(getCharByNumber(decimalResult % to)!, at: answer.startIndex)
    }
    
    if minus {
        answer.insert(minusSign, at: value.startIndex)
    }
    
    return answer
}





class test_LR12: XCTestCase {
    
    func testCharNumber() {
        XCTAssertEqual(getNumberOfChar("0"), 0)
        XCTAssertEqual(getNumberOfChar("1"), 1)
        XCTAssertEqual(getNumberOfChar("A"), 10)
        XCTAssertEqual(getNumberOfChar("Z"), 35)
        
        XCTAssertEqual(getNumberOfChar("z"), nil)
        XCTAssertEqual(getNumberOfChar("-"), nil)
        XCTAssertEqual(getNumberOfChar("a"), nil)
    }
    
    func testNotation() {
        XCTAssertEqual(checkNotation(2, withValue: "-10"), true)
        XCTAssertEqual(checkNotation(3, withValue: "12"), true)
        XCTAssertEqual(checkNotation(3, withValue: "-13"), false)
        XCTAssertEqual(checkNotation(1, withValue: "0"), false)
        XCTAssertEqual(checkNotation(16, withValue: "A"), true)
        XCTAssertEqual(checkNotation(16, withValue: "-F"), true)
        XCTAssertEqual(checkNotation(16, withValue: "G"), false)
        XCTAssertEqual(checkNotation(36, withValue: "Z"), true)
    }
    
    func testNumberChar() {
        XCTAssertEqual(getCharByNumber(0), "0")
        XCTAssertEqual(getCharByNumber(1), "1")
        XCTAssertEqual(getCharByNumber(10), "A")
        XCTAssertEqual(getCharByNumber(15), "F")
        XCTAssertEqual(getCharByNumber(35), "Z")
        XCTAssertEqual(getCharByNumber(36), nil)
        XCTAssertEqual(getCharByNumber(-1), nil)
    }
    
    func testConvertion() {
        XCTAssertEqual(convertValue("-A", fromNotation: 11, toNotation: 2), "-1010")
        XCTAssertEqual(convertValue("AAA", fromNotation: 27, toNotation: 2), "1110110010010")
        XCTAssertEqual(convertValue("ZZZZ", fromNotation: 36, toNotation: 16), "19A0FF")
        XCTAssertEqual(convertValue("-AHYB", fromNotation: 35, toNotation: 13), "-12A241")
        XCTAssertEqual(convertValue("ABABABAB", fromNotation: 18, toNotation: 3), "121211010211211011002")
        XCTAssertEqual(convertValue("1000000", fromNotation: 2, toNotation: 10), "64")
        XCTAssertEqual(convertValue("-5656565656", fromNotation: 7, toNotation: 8), "-1630323655")
        XCTAssertEqual(convertValue("0", fromNotation: 2, toNotation: 2), "0")
        XCTAssertEqual(convertValue("-0", fromNotation: 2, toNotation: 2), "-0")
    }
    
}
