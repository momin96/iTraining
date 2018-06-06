//: Playground - noun: a place where people can play

import Cocoa

let nums = [1, 6, 3, 9, 4, 6];
let numMax = nums.reduce(Int.min, { max($0, $1) })

print(numMax)
