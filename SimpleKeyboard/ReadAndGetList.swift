//
//  ReadAndGetList.swift
//  SimpleKeyboard
//
//  Created by David Xu on 9/08/22.
//

import Foundation
import KeyboardKit
import UIKit

extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}


func csv(data: String) -> [[String]] {
    var result: [[String]] = []
    let rows = data.components(separatedBy: "\n")
    for row in rows {
        let columns = row.components(separatedBy: ",")
        result.append(columns)
    }
    return result
}
// grabbing thing from words list,
// idk what next
func readDataFromCSV(fileName:String, fileType: String)-> String!{
        guard let filepath = Bundle.main.path(forResource: fileName, ofType: fileType)
            else {
                return nil
        }
        do {
            var contents = try String(contentsOfFile: filepath, encoding: .utf8)
            contents = cleanRows(file: contents)
            return contents
        } catch {
            print("File Read Error for file \(filepath)")
            return nil
        }
    }


func cleanRows(file:String)->String{
    var cleanFile = file
    cleanFile = cleanFile.replacingOccurrences(of: "\r", with: "\n")
    cleanFile = cleanFile.replacingOccurrences(of: "\n\n", with: "\n")
    //        cleanFile = cleanFile.replacingOccurrences(of: ";;", with: "")
    //        cleanFile = cleanFile.replacingOccurrences(of: ";\n", with: "")
    return cleanFile
}
func getRows() -> [Array<String>] {
    var data = readDataFromCSV(fileName: "vocabulary-list", fileType: "csv")
    data = cleanRows(file: data!)
    let csvRows = csv(data: data!)
    return csvRows
}
func makeFirstLetterDict() -> [Character: Int] {
    let csvRows = getRows()
    var firstLetterDict: [Character:Int] = [:]
    let AlphabetList = "abcdefghijklmnopqrstuvwxyz"
    var firstLetterFound: [Character] = []
    // Good practice!
    for letter in 0...AlphabetList.count-1{
        firstLetterDict[AlphabetList[letter]] = letter
    }
    // alright inilization done can pass now just accessing vocab list
    for rowLetter in 0...csvRows.count-2 {
        let cString = csvRows[rowLetter][0]
        if firstLetterFound.contains(cString[0]){
        } else{
            firstLetterFound.append(cString[0])
            firstLetterDict[cString[0]] = rowLetter
        }
    }
    // this goes from 0 to 25
    return firstLetterDict
}

// return lists of words
func getWordsList() -> [String] {
    let csvRows = getRows()
    var wordsList: [String] = []
    for rowLetter in 0...csvRows.count-2 {
        let cString = csvRows[rowLetter][0]
        wordsList.append(cString)
    }
    return wordsList
}
