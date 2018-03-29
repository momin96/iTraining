//: Playground - noun: a place where people can play

import UIKit

enum Result<T, U> {
    case Success(T)
    case Failure(U)
}

let aSuccess : Result<Int, String> = .Success(123)
let aFailure : Result<Int, String> = .Failure("temprature is too high")
//let newSuccess : Result<[Int]> = .Success([1,2,3])



















