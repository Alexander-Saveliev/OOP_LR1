//
//  main.swift
//  LR12
//
//  Created by Marty on 11/02/2018.
//  Copyright © 2018 Marty. All rights reserved.
//

import Foundation

let argv = getArgv()

assert(Int(argv[1]) != nil && Int(argv[2]) != nil, "Incorrect input. First & second arguments must be Int")
let sourceNotation      = Int(argv[1])!
let destinationNotation = Int(argv[2])!
var value               = argv[3]

assert(checkNotation(sourceNotation, withValue: value) == true, "I can't get \(value) with notation \(sourceNotation)")
assert(destinationNotation >= 2 && destinationNotation <= 36, "Incorrect destination notation \(destinationNotation)")

let result = convertValue(value, fromNotation: sourceNotation, toNotation: destinationNotation)

print(result)
