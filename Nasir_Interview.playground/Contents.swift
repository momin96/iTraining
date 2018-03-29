//: Playground - noun: a place where people can play

import Foundation
// ========================================================================================================================
/**
 Objective: After 2 task finished which are in queue concurrently, then start 3rd task using GCD & Operation Queues
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
    downloadAVIGroup.leave()
}

downloadAVIGroup.enter()
APIClient { (aviaData, finsihed) in
    downloadAVIGroup.leave()
}

downloadAVIGroup.notify(queue: DispatchQueue.global(qos: .background)) {
    computationOfDataForRendering()
}


// ========================================================================================================================
// ========================================================================================================================


struct OperationFinished {
    var networkOperationFinished = false
    var computationOperationFinished = false
}
let validOperation = OperationFinished()


let networkOperation : Operation? = Operation()
let resizeOperation : Operation? = Operation()
let computeOperation : Operation? = Operation()

func startResizeOperation () {
    if validOperation.networkOperationFinished && validOperation.computationOperationFinished {
        resizeOperation?.start()
    }
}

let mainQueue = OperationQueue.main
mainQueue.addOperations([networkOperation!, computeOperation!], waitUntilFinished: true)

networkOperation?.completionBlock = {
    print("Network operation completed successfully")
    startResizeOperation()
}

computeOperation?.completionBlock = {
    print("Compute operation completed successfully")
    startResizeOperation()
}

resizeOperation?.completionBlock = {
    print("Resize operation completed successfully")
}

resizeOperation?.addDependency(networkOperation!)
resizeOperation?.addDependency(computeOperation!)





