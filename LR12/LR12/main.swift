//
//  main.swift
//  LR12
//
//  Created by Marty on 11/02/2018.
//  Copyright © 2018 Marty. All rights reserved.
//

import Foundation

let sourceNotation      = 10
let destinationNotation = 16
var value               = ""
let answer              = "34"

assert(checkNotation(sourceNotation, withValue: value) == true, "I can't get \(value) with notation \(sourceNotation)")
assert(destinationNotation >= 2 && destinationNotation <= 36, "Incorrect destination notation \(destinationNotation)")

let result = convertValue(value, fromNotation: sourceNotation, toNotation: destinationNotation)

print(result)
