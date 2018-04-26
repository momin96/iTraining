//
//  Document.swift
//  ZIPSpector
//
//  Created by Nasir Ahmed Momin on 26/04/18.
//  Copyright © 2018 Nasir Ahmed Momin. All rights reserved.
//

import Cocoa

class Document: NSDocument, NSTableViewDataSource {

    
    @IBOutlet weak var tableView : NSTableView!
    
    var filenames : [String] = []
    
    override init() {
        super.init()
        // Add your subclass-specific initialization here.
    }

    override class var autosavesInPlace: Bool {
        return true
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return filenames.count
    }
    
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        return filenames[row]
    }
    

    override var windowNibName: NSNib.Name? {
        // Returns the nib file name of the document
        // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this property and override -makeWindowControllers instead.
        return NSNib.Name("Document")
    }

    override func data(ofType typeName: String) throws -> Data {
        // Insert code here to write your document to data of the specified type. If outError != nil, ensure that you create and set an appropriate error when returning nil.
        // You can also choose to override fileWrapperOfType:error:, writeToURL:ofType:error:, or writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.
        throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
    }

    override func read(from url: URL, ofType typeName: String) throws {
        let filename = url.path
        
        let task = Process()
        task.launchPath = "/usr/bin/zipinfo"
        task.arguments = ["-1", filename]

        let outPipe = Pipe()
        task.standardOutput = outPipe
        
        task.launch()
        
        let fileHandle = outPipe.fileHandleForReading
        let data = fileHandle.readDataToEndOfFile()
        
        task.waitUntilExit()
        let status = task.terminationStatus
        
        if status != 0 {
            let errorDomain = "com.bignerdranch.ProcessReturnCodeErrorDomain"
            let errorInfo = [NSLocalizedFailureReasonErrorKey : "zipInfo return \(status)"]
            throw NSError(domain: errorDomain, code: 0, userInfo: errorInfo)
        }
        
        let stringName =  String.init(data: data, encoding: .utf8)
        filenames = (stringName?.components(separatedBy: "\n"))! as [String]
        
        Swift.print("filenames \(filenames)")
        
        tableView.reloadData()
    }
    
    override func read(from data: Data, ofType typeName: String) throws {
        // Insert code here to read your document from the given data of the specified type. If outError != nil, ensure that you create and set an appropriate error when returning false.
        // You can also choose to override readFromFileWrapper:ofType:error: or readFromURL:ofType:error: instead.
        // If you override either of these, you should also override -isEntireFileLoaded to return false if the contents are lazily loaded.
        throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
    }


}

