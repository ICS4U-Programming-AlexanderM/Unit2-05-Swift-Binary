import Foundation
//  Created by Alexander Matheson
//  Created on 2023-Apr-24
//  Version 1.0
//  Copyright (c) 2023 Alexander Matheson. All rights reserved.
//
//  This program uses a binary search to find the index of a number.

// Enum for error checking.
enum InputError: Error {
  case InvalidInput
}

// Input in separate function for error checking.
func convert(strUnconverted: String) throws -> Int {
  guard let numConverted = Int(strUnconverted.trimmingCharacters(in: CharacterSet.newlines)) else {
    throw InputError.InvalidInput
  }
  return numConverted
}

// This function uses a binary search.
func search(listOfNum: [Int], searchNum: Int, start: Int, end: Int) -> Int {
  // Base case 1: number not found in list.
  if start > end {
    return -1
  }

  // Set mid point.
  let mid = (start + end) / 2

  if listOfNum[mid] == searchNum {
    return mid
  } else if listOfNum[mid] > searchNum {
    return search(listOfNum: listOfNum, searchNum: searchNum, start: start, end: mid - 1)
  } else {
    return search(listOfNum: listOfNum, searchNum: searchNum, start: mid + 1, end: end)
  }
}

// Read in lines from input.txt.
let inputFile = URL(fileURLWithPath: "input.txt")
let inputData = try String(contentsOf: inputFile)
let lineArray = inputData.components(separatedBy: .newlines)

// Open the output file for writing.
let outputFile = URL(fileURLWithPath: "output.txt")

// Call function and print to output file.
var indexString = ""
var counter = 0
var length: Int
while counter < lineArray.count {
  // Convert to int.
  let tempArr = lineArray[counter].components(separatedBy: " ")
  var numArr: [Int] = []
  let searchNum = try convert(strUnconverted: lineArray[counter + 1])
  for location in tempArr {
    numArr.append(Int(location)!)
  }

  // Sort array.
  numArr.sort()

  // Call function and output results.
  let index = search(listOfNum: numArr, searchNum: searchNum, start: 0, end: numArr.count - 1)
  print(index)
  indexString = indexString + "\(index)\n"
  try indexString.write(to: outputFile, atomically: true, encoding: .utf8)
  counter = counter + 2
}
