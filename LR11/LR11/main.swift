//
//  main.swift
//  LR11
//
//  Created by Marty on 06/02/2018.
//  Copyright © 2018 Marty. All rights reserved.
//


import Cocoa

func replaceIn(_ str: String, find: String, replace: String) -> String {
    guard str.count >= find.count && find != "" else {
        return str
    }
    
    var outString = ""
    var waiting = 0
    
    var start = str.startIndex
    var end   = str.index(start, offsetBy: find.count - 1)
    
    // waiting неудачное имя
    while end != str.endIndex {
        if waiting != 0 {
            waiting -= 1
        } else {
            if str[start...end] == find {
                outString.append(replace)
                waiting = find.count - 1
            } else {
                outString.append(str[start])
            }
        }
        
        start = str.index(after: start)
        end   = str.index(after: end)
    }
    
    if waiting != 0 {
        start = str.index(start, offsetBy: waiting)
    }
    
    outString+=str[start..<str.endIndex]
    
    return outString
}


func getArgy() -> [String] {
    assert(CommandLine.arguments.count == 5, "Incorrect number of arguments. It must be 4")
    
    let argy = CommandLine.arguments
    
    return argy
}


///////////////////////////


// <file name> <input file> <output file> <search string> <replace string>
let argy = getArgy()

let inputFile  = argy[1]
let outputFile = argy[2]
let find       = argy[3]
let replace    = argy[4]

assert(find != "", "The search string must not be empty")

// get files URL
let dirURL        = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
let inputFileURL  = dirURL.appendingPathComponent(inputFile)
let outputFileURL = dirURL.appendingPathComponent(outputFile)


var outputText = [String]()

// reading from file
do {
    let text = try String(contentsOf: inputFileURL).components(separatedBy: "\n") as [String]
    
    for str in text where str != "" {
        outputText.append(replaceIn(str, find: find, replace: replace))
    }
} catch {
    print("Failed reading from URL: \(inputFileURL), Error: " + error.localizedDescription)
}

// Write to the file named Test
var out = ""

for str in outputText {
    out.append(str + "\n")
}

do {
    try out.write(to: outputFileURL, atomically: true, encoding: .utf8)
} catch {
    print("Failed writing to URL: \(outputFileURL), Error: " + error.localizedDescription)
}


