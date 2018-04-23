//: Playground - noun: a place where people can play

import UIKit

// 배열
var integers: Array<Int> = Array<Int>()
// 배열 생성
//var integers: Array<Int> = [Int]()
//var integers: [Int] = Array<Int>()
//var integers: [Int] = [Int]()
//var integers: [Int] = []
//var intefers = [Int]()

// 값 추가
integers.append(1)
integers.append(100)

// 값 포함 여부
print(integers.contains(100))
print(integers.contains(33))

// 값 수정
integers[0] = 99

// 값 삭제
integers.remove(at: 0)
integers.removeLast()
integers.removeAll()

// 값 수
print(integers.count)

// 딕셔너리
var anyDictionary: Dictionary<String, Any> = [String: Any]()
// 딕셔너리 생성
//var anyDictionary: Dictionary<String, Any> = Dictionary<String, Any>()
//var anyDictionary: Dictionary<String, Any> = [:]
//var anyDictionary: [String: Any] = Dictionary<String, Any>()
//var anyDictionary: [String: Any] = [:]
//var anyDictionary = [String: Any]()

// 값 추가
anyDictionary["someKey"] = "value"
anyDictionary["anotherKey"] = 100

// 값 수정
anyDictionary["someKey"] = "dictionary"

// 값 제거
anyDictionary.removeValue(forKey: "anotherKey")
anyDictionary["someKey"] = nil

// Set
var integerSet: Set<Int> = Set<Int>()

// 값 추가
integerSet.insert(1)
integerSet.insert(38)

// 값 포함 여부
print(integerSet.contains(78))

// 값 삭제
integerSet.remove(1)
integerSet.removeFirst()

// 값 수
print(integerSet.count)

let setA: Set<Int> = [1, 2, 3, 4, 5]
let setB: Set<Int> = [3, 4, 5, 6, 7]

// 합집합
let union: Set<Int> = setA.union(setB)
print(union)

// 합집합 오름차순 정렬
let sortedUnion: [Int] = union.sorted()
print(sortedUnion)

// 교집합
let intersection: Set<Int> = setA.intersection(setB)
print(integerSet)

// 차집합
let subtracting: Set<Int> = setA.subtracting(setB)
print(subtracting)
