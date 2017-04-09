//: Playground - noun: a place where people can play

import Cocoa
import ChessToolkit

func printPosValues(pos: CTPosition) {
  print("Pos: \(pos.hashKey) \(pos.calculateHashKey())")
}


let pos = CTPosition()

pos.makeMove(from: .e2, to: .e4)
pos.makeMove(from: .e7, to: .e5)
pos.makeMove(from: .g1, to: .f3)
pos.makeMove(from: .b8, to: .c6)
pos.makeMove(from: .f1, to: .b5)
pos.makeMove(from: .g8, to: .f6)

print(pos)
print(pos.hashKey)

pos.makeMove(from: .e1, to: .e2)
pos.makeMove(from: .f6, to: .g8)
pos.makeMove(from: .e2, to: .e1)
pos.makeMove(from: .g8, to: .f6)

print(pos)
print(pos.hashKey)
