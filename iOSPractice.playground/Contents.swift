//: Playground - noun: a place where people can play

import UIKit
import Foundation

// ========================================================================================================================
/**
 Objective: After 2 task finished which are in queue concurrently, then start 3rd task using GCD
 To demonstrate use of DispathGroup, enter(), leave(), notify(), escaping & non escaping closure
 */

let downloadAVIGroup = DispatchGroup()
let computeDataGroup = DispatchGroup()
var captureClousure : Any?

func APIClient(_ onCompletion :@escaping (Data, Bool) -> Void) {
    
    // No error because of @escaping
    captureClousure = onCompletion

    // Downloading of data finished...
    let aviData = Data()
    onCompletion(aviData, true)
}

func computationOnCompletion(_ onCompletion : (Bool) -> Void) {
    // Error: cannot capure closure because it is by default non escaping
//    captureClousure = onCompletion
    onCompletion(true)
}

func computationOfDataForRendering () {
    
    computeDataGroup.enter()
    computationOnCompletion { (finished) in
        computeDataGroup.leave()
    }
    
    computeDataGroup.notify(queue: .main) {
        // Data computation finished.
        // Render now on UI
    }
}

downloadAVIGroup.enter()
APIClient { (aviData, finished) in
    downloadAVIGroup.leave();
}

downloadAVIGroup.enter()
APIClient { (aviaData, finsihed) in
    downloadAVIGroup.leave();
}

downloadAVIGroup.notify(queue: DispatchQueue.global(qos: .background)) {
    computationOfDataForRendering()
}



// ========================================================================================================================
// ========================================================================================================================




//let backgroundOperation = Operation();
//backgroundOperation.queuePriority = .veryLow
//backgroundOperation.qualityOfService = .background
//
//let operationQueue = OperationQueue.main
//operationQueue.addOperation(backgroundOperation)
//
//
//let networkOperation : Operation? = Operation()
//let resizeOperation : Operation?
//let computeOperation : Operation?
//
//resizeOperation?.addDependency(networkOperation)
//
//let mainQueue = OperationQueue.main
//mainQueue.addOperations([networkOperation, resizeOperation], waitUntilFinished: true)
//
//networkOperation?.completionBlock = {
//    print("Network operation completed successfully")
//}
//
//resizeOperation?.completionBlock = {
//    print("Resize operation completed successfully")
//}
//
//let backgroundQueue = OperationQueue()
//backgroundQueue.qualityOfService = .background





