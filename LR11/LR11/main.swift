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
    
    var outString     = ""
    var iterationSkip = 0
    
    var start = str.startIndex
    var end   = str.index(start, offsetBy: find.count - 1)
    
    while end != str.endIndex {
        if iterationSkip != 0 {
            iterationSkip -= 1
        } else {
            if str[start...end] == find {
                outString.append(replace)
                iterationSkip = find.count - 1
            } else {
                outString.append(str[start])
            }
        }
        
        start = str.index(after: start)
        end   = str.index(after: end)
    }
    
    if iterationSkip != 0 {
        start = str.index(start, offsetBy: iterationSkip)
    }
    
    outString+=str[start..<str.endIndex]
    
    return outString
}


func getArgv() -> [String] {
    assert(CommandLine.arguments.count == 5, "Incorrect number of arguments. It must be 4")
    
    let argv = CommandLine.arguments
    
    return argv
}


///////////////////////////


// <file name> <input file> <output file> <search string> <replace string>
let argv = getArgv()

let inputFile  = argv[1]
let outputFile = argv[2]
let find       = argv[3]
let replace    = argv[4]

assert(find != "", "The search string must not be empty")


let pathURL       = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
let inputFileURL  = pathURL.appendingPathComponent(inputFile)
let outputFileURL = pathURL.appendingPathComponent(outputFile)


let streamReading = StreamReader(url: inputFileURL)
assert(streamReading != nil, "I can't find input file")


// creation out_.txt
do {
    try "".write(to: outputFileURL, atomically: false, encoding: String.Encoding.utf8)
}
catch {
    print("Failed writing to URL: \(outputFileURL), Error: " + error.localizedDescription)
}


// Open for writing to end of file
let outPath = FileManager.default.currentDirectoryPath + "/\(outputFile)"
assert(FileHandle(forWritingAtPath: outPath) != nil, "Failed to write into file")
let fh = FileHandle(forWritingAtPath: outPath)!

fh.seekToEndOfFile()


// Reading file line by line
while let str = streamReading?.nextLine() {
    let replacedString = replaceIn(str, find: find, replace: replace) + "\n"
    let data = replacedString.data(using: .utf8, allowLossyConversion: false)
    assert(data != nil, "Failed convert data for writing into file")
    
    fh.write(data!)
}

fh.closeFile()



