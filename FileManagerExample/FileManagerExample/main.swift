//
//  main.swift
//  FileManagerExample
//
//  Created by Jinu Kim on 02/10/2018.
//  Copyright © 2018 Jinu Kim. All rights reserved.
//

import Foundation

let fileManager = FileManager()
let desktopPath = "/Users/kakaotocs/Desktop"
let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
let dataPath = documentsDirectory.appendingPathComponent("FileManger Directory")

func accessDirectory() {
    print("Access directory: \(desktopPath)")
    do {
        let contents = try fileManager.contentsOfDirectory(atPath: desktopPath)
        let deeperContents = try fileManager.subpathsOfDirectory(atPath: desktopPath)
        
        print(contents)
        print(deeperContents)
    } catch let error as Error {
        print("Error >> access >> directory: \(error)")
    }
}

func createDirectory() {
    print("Create directory: \(dataPath)")
    do {
        try fileManager.createDirectory(at: dataPath, withIntermediateDirectories: false, attributes: nil)
    } catch let error as Error {
        print("Error >> creating >> directory: \(error.localizedDescription)")
    }
}

func writeFile() {
    do {
        let helloPath = dataPath.appendingPathComponent("Hello.txt")
        print("Write file: \(helloPath)")
        let data = "Hello File From Swift"
        
        do {
            try data.write(to: helloPath, atomically: false, encoding: .utf8)
        }
    } catch let error as Error {
        print("Error >> write >> file: \(error.localizedDescription)")
    }
}

func readFile() {
    do {
        let helloPath = dataPath.appendingPathComponent("Hello.txt")
        print("Read file: \(helloPath)")
        let textData = try String(contentsOf: helloPath, encoding: .utf8)
        print(textData)
    } catch let error as Error {
        print("Error >> read >> file:\(error.localizedDescription)")
    }
}

func main() {
//    accessDirectory()
//    createDirectory()
//    writeFile()
//    readFile()
}

main()
