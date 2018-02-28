//
//  someLib.swift
//  LR12
//
//  Created by Marty on 11/02/2018.
//  Copyright © 2018 Marty. All rights reserved.
//

import Foundation

func runAppWithargv(_ argv: [String]) {
    let programName = "LR12"
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


func getArgv() -> [String] {
    assert(CommandLine.arguments.count == 4, "Incorrect number of arguments. It must be 3")
    
    let argv = CommandLine.arguments
    
    return argv
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
    
    for digit in value.reversed() {
        assert(Int.max - (decimalResult * 10 + getNumberOfChar(digit)!) > 0, "Overflow")
        decimalResult = decimalResult * 10 + getNumberOfChar(digit)!
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
