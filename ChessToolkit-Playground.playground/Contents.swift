//: Playground - noun: a place where people can play

import Cocoa
import ChessToolkit

func printPosValues(pos: CTPosition) {
  print("Pos: \(pos.hashKey) \(pos.calculateHashKey())")
}

let pos = CTPosition()

pos.makeMove(from: .d2, to: .d4)
pos.makeMove(from: .h7, to: .h6)
pos.makeMove(from: .d4, to: .d5)
pos.makeMove(from: .e7, to: .e5)

print(pos.enPassantSquare?.toString() ?? "No square")

pos.takeBackMove()

print(pos.enPassantSquare?.toString() ?? "No square")

