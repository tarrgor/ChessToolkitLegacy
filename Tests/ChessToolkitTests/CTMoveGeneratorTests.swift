//
//  CTMoveGeneratorTests.swift
//  ChessToolkit
//
//  Created by Thorsten Klusemann on 16.07.15.
//  Copyright (c) 2015 Thorsten Klusemann. All rights reserved.
//

import XCTest
@testable import ChessToolkit

class CTMoveGeneratorTests: XCTestCase {
  
  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  func testWhitePawnMovesWithInitialPosition() {
    let pos = CTPosition()
    let gen = CTMoveGenerator(position: pos)
    
    let moves = gen.generateWhitePawnMoves()
    
    XCTAssert(moves.count == 16, "Move count is not 16.")
    XCTAssertTrue(moveHasBeenFound(moves, from: .e2, to: .e4), "e2e4 has not been found.")
    XCTAssertTrue(moveHasBeenFound(moves, from: .c2, to: .c3), "c2c3 has not been found.")
    XCTAssertTrue(moveHasBeenFound(moves, from: .g2, to: .g4), "g2g4 has not been found.")
    XCTAssertFalse(moveHasBeenFound(moves, from: .g2, to: .g5), "g2g5 has been found.")
    XCTAssertFalse(moveHasBeenFound(moves, from: .a2, to: .b3), "a2b3 has been found.")
    XCTAssertFalse(moveHasBeenFound(moves, from: .e2, to: .d3), "e2d3 has been found.")
  }
  
  func testWhitePawnMovesAfterMovesA3andH6() {
    let pos = CTPosition(fen: "rnbqkbnr/ppppppp1/7p/8/8/P7/1PPPPPPP/RNBQKBNR w KQkq - 2 2")
    let gen = CTMoveGenerator(position: pos)
    
    let moves = gen.generateWhitePawnMoves()
    
    XCTAssert(moves.count == 15, "Move count is not 15.")
    XCTAssertTrue(moveHasBeenFound(moves, from: .e2, to: .e4), "e2e4 has not been found.")
    XCTAssertTrue(moveHasBeenFound(moves, from: .c2, to: .c3), "c2c3 has not been found.")
    XCTAssertTrue(moveHasBeenFound(moves, from: .a3, to: .a4), "a3a4 has not been found.")
    XCTAssertFalse(moveHasBeenFound(moves, from: .a3, to: .a5), "a3a5 has been found.")
    XCTAssertFalse(moveHasBeenFound(moves, from: .a2, to: .b3), "a2b3 has been found.")
    XCTAssertFalse(moveHasBeenFound(moves, from: .e2, to: .d3), "e2d3 has been found.")
  }
  
  func testWhitePawnMovesAfterMovesD4AndE5() {
    let pos = CTPosition(fen: "rnbqkbnr/pppp1ppp/8/4p3/3P4/8/PPP1PPPP/RNBQKBNR w KQkq - 2 2")
    let gen = CTMoveGenerator(position: pos)
    
    let moves = gen.generateWhitePawnMoves()
    
    XCTAssertTrue(moveHasBeenFound(moves, from: .d4, to: .e5), "d4e5 has not been found.")
    XCTAssertFalse(moveHasBeenFound(moves, from: .d4, to: .c5), "d4c5 has been found.")
  }
  
  func testWhitePawnMovesWithEnPassantFieldOnD6() {
    let pos = CTPosition(fen: "rnbqkbnr/p1p1ppp1/1p5p/3pP3/8/P7/1PPP1PPP/RNBQKBNR w KQkq d6 6 4")
    let gen = CTMoveGenerator(position: pos)
    
    let moves = gen.generateWhitePawnMoves()
    
    XCTAssertTrue(moveHasBeenFound(moves, from: .e5, to: .d6), "En passant move not found.")
    XCTAssertTrue(moveHasBeenFound(moves, from: .e5, to: .e6), "e5e6 has not been found.")
    XCTAssertFalse(moveHasBeenFound(moves, from: .e5, to: .f6), "e5f6 has been found.")
  }
  
  func testBlackPawnMovesWithInitialPosition() {
    let pos = CTPosition()
    let gen = CTMoveGenerator(position: pos)
    
    let moves = gen.generateBlackPawnMoves()
    
    XCTAssert(moves.count == 16, "Move count is not 16.")
    XCTAssertTrue(moveHasBeenFound(moves, from: .e7, to: .e5), "e7e5 has not been found.")
    XCTAssertTrue(moveHasBeenFound(moves, from: .c7, to: .c6), "c7c6 has not been found.")
    XCTAssertTrue(moveHasBeenFound(moves, from: .g7, to: .g5), "g7g5 has not been found.")
    XCTAssertFalse(moveHasBeenFound(moves, from: .g7, to: .g4), "g7g4 has been found.")
    XCTAssertFalse(moveHasBeenFound(moves, from: .a7, to: .b6), "a7b6 has been found.")
    XCTAssertFalse(moveHasBeenFound(moves, from: .e7, to: .d6), "e7d6 has been found.")
  }
  
  func testBlackPawnMovesAfterMovesA3andH6() {
    let pos = CTPosition(fen: "rnbqkbnr/ppppppp1/7p/8/8/P7/1PPPPPPP/RNBQKBNR w KQkq - 2 2")
    let gen = CTMoveGenerator(position: pos)
    
    let moves = gen.generateBlackPawnMoves()
    
    XCTAssert(moves.count == 15, "Move count is not 15.")
    XCTAssertTrue(moveHasBeenFound(moves, from: .e7, to: .e5), "e7e5 has not been found.")
    XCTAssertTrue(moveHasBeenFound(moves, from: .c7, to: .c6), "c7c6 has not been found.")
    XCTAssertTrue(moveHasBeenFound(moves, from: .h6, to: .h5), "h6h5 has not been found.")
    XCTAssertFalse(moveHasBeenFound(moves, from: .h6, to: .h4), "h6h4 has been found.")
    XCTAssertFalse(moveHasBeenFound(moves, from: .a7, to: .b6), "a7b6 has been found.")
    XCTAssertFalse(moveHasBeenFound(moves, from: .e7, to: .d6), "e7d6 has been found.")
  }
  
  func testBlackPawnMovesAfterMovesD4AndE5() {
    let pos = CTPosition(fen: "rnbqkbnr/pppp1ppp/8/4p3/3P4/8/PPP1PPPP/RNBQKBNR w KQkq - 2 2")
    let gen = CTMoveGenerator(position: pos)
    
    let moves = gen.generateBlackPawnMoves()
    
    XCTAssertTrue(moveHasBeenFound(moves, from: .e5, to: .d4), "e5d4 has not been found.")
    XCTAssertFalse(moveHasBeenFound(moves, from: .e5, to: .f4), "e5f4 has been found.")
  }
  
  func testBlackPawnMovesWithEnPassantFieldOnF3() {
    let pos = CTPosition(fen: "rnbqkbnr/pppp1ppp/8/8/4pP2/6PP/PPPPP3/RNBQKBNR b KQkq f3 5 3")
    let gen = CTMoveGenerator(position: pos)
    
    let moves = gen.generateBlackPawnMoves()
    
    XCTAssertTrue(moveHasBeenFound(moves, from: .e4, to: .f3), "En passant move not found.")
    XCTAssertTrue(moveHasBeenFound(moves, from: .e4, to: .e3), "e4e3 has not been found.")
    XCTAssertFalse(moveHasBeenFound(moves, from: .e4, to: .d3), "e4d3 has been found.")
  }
  
  func testWhiteKnightMovesInitialPosition() {
    let pos = CTPosition()
    let gen = CTMoveGenerator(position: pos)
    
    let moves = gen.generateKnightMoves(.white)
    
    XCTAssertTrue(moves.count == 4, "Move count not 4.")
    XCTAssertTrue(moveHasBeenFound(moves, from: .g1, to: .f3), "g1f3 not found.")
    XCTAssertTrue(moveHasBeenFound(moves, from: .b1, to: .a3), "b1a3 not found.")
    XCTAssertFalse(moveHasBeenFound(moves, from: .b1, to: .b3), "b1b3 found.")
    XCTAssertFalse(moveHasBeenFound(moves, from: .b1, to: .d2), "b1d2 found, square d2 is blocked.")
  }
  
  func testBlackKnightMovesInitialPosition() {
    let pos = CTPosition()
    let gen = CTMoveGenerator(position: pos)
    
    let moves = gen.generateKnightMoves(.black)
    
    XCTAssertTrue(moves.count == 4, "Move count not 4.")
    XCTAssertTrue(moveHasBeenFound(moves, from: .g8, to: .f6), "g8f6 not found.")
    XCTAssertTrue(moveHasBeenFound(moves, from: .b8, to: .a6), "b8a6 not found.")
    XCTAssertFalse(moveHasBeenFound(moves, from: .b8, to: .b6), "b8b6 found.")
    XCTAssertFalse(moveHasBeenFound(moves, from: .b8, to: .d7), "b8d7 found, square d7 is blocked.")
  }
  
  func testWhiteBishopMovesInitialPositionShouldBeEmpty() {
    let pos = CTPosition()
    let gen = CTMoveGenerator(position: pos)
    
    let moves = gen.generateBishopMoves(.white)
    
    XCTAssertTrue(moves.count == 0, "Move count not 0.")
  }
  
  func testWhiteBishopMovesAfterE4AndE5() {
    let pos = CTPosition(fen: "rnbqkbnr/pppp1ppp/8/4p3/4P3/8/PPPP1PPP/RNBQKBNR w KQkq - 2 2")
    let gen = CTMoveGenerator(position: pos)
    
    let moves = gen.generateBishopMoves(.white)
    
    XCTAssertTrue(moves.count == 5, "Move count is not 5.")
    XCTAssertTrue(moveHasBeenFound(moves, from: .f1, to: .c4), "f1c4 not found.")
    XCTAssertFalse(moveHasBeenFound(moves, from: .f1, to: .g2), "f1g2 found, square is blocked.")
    XCTAssertFalse(moveHasBeenFound(moves, from: .f1, to: .h3), "f1g2 found, square is blocked.")
  }
  
  func testBlackBishopMovesAfterE4AndE5() {
    let pos = CTPosition(fen: "rnbqkbnr/pppp1ppp/8/4p3/4P3/8/PPPP1PPP/RNBQKBNR w KQkq - 2 2")
    let gen = CTMoveGenerator(position: pos)
    
    let moves = gen.generateBishopMoves(.black)
    
    XCTAssertTrue(moves.count == 5, "Move count is not 5.")
    XCTAssertTrue(moveHasBeenFound(moves, from: .f8, to: .c5), "f8c5 not found.")
    XCTAssertFalse(moveHasBeenFound(moves, from: .f8, to: .g7), "f8g7 found, square is blocked.")
    XCTAssertFalse(moveHasBeenFound(moves, from: .f8, to: .h6), "f8h6 found, square is blocked.")
  }
  
  func testWhiteRookMovesAfterA4AndA5() {
    let pos = CTPosition(fen: "rnbqkbnr/1ppppppp/8/p7/P7/8/1PPPPPPP/RNBQKBNR w KQkq - 2 2")
    let gen = CTMoveGenerator(position: pos)
    
    let moves = gen.generateRookMoves(.white)
    
    XCTAssertTrue(moves.count == 2, "Move count is not 2.")
    XCTAssertTrue(moveHasBeenFound(moves, from: .a1, to: .a3), "a1a3 not found.")
    XCTAssertFalse(moveHasBeenFound(moves, from: .a1, to: .b1), "a1b1 found, square is blocked.")
    XCTAssertFalse(moveHasBeenFound(moves, from: .a1, to: .a5), "a1a5 found, square is blocked.")
  }
  
  func testBlackRookMovesAfterA4AndA5() {
    let pos = CTPosition(fen: "rnbqkbnr/1ppppppp/8/p7/P7/8/1PPPPPPP/RNBQKBNR w KQkq - 2 2")
    let gen = CTMoveGenerator(position: pos)
    
    let moves = gen.generateRookMoves(.black)
    
    XCTAssertTrue(moves.count == 2, "Move count is not 2.")
    XCTAssertTrue(moveHasBeenFound(moves, from: .a8, to: .a6), "a8a6 not found.")
    XCTAssertFalse(moveHasBeenFound(moves, from: .a8, to: .b7), "a8b7 found, square is blocked.")
    XCTAssertFalse(moveHasBeenFound(moves, from: .a8, to: .a4), "a8a4 found, square is blocked.")
  }
  
  func testWhiteQueenMovesAfterE4E5D4D5() {
    let pos = CTPosition(fen: "rnbqkbnr/ppp2ppp/8/3pp3/3PP3/8/PPP2PPP/RNBQKBNR w KQkq - 4 3")
    let gen = CTMoveGenerator(position: pos)
    
    let moves = gen.generateQueenMoves(.white)
    
    XCTAssertTrue(moves.count == 6, "Move count is not 6.")
    XCTAssertTrue(moveHasBeenFound(moves, from: .d1, to: .d2), "d1d2 not found.")
    XCTAssertTrue(moveHasBeenFound(moves, from: .d1, to: .h5), "d1h5 not found.")
    XCTAssertFalse(moveHasBeenFound(moves, from: .d1, to: .c2), "d1c2 found, square is blocked.")
    XCTAssertFalse(moveHasBeenFound(moves, from: .d1, to: .b3), "d1b3 found, square is blocked.")
  }
  
  func testBlackQueenMovesAfterE4E5D4D5() {
    let pos = CTPosition(fen: "rnbqkbnr/ppp2ppp/8/3pp3/3PP3/8/PPP2PPP/RNBQKBNR w KQkq - 4 3")
    let gen = CTMoveGenerator(position: pos)
    
    let moves = gen.generateQueenMoves(.black)
    
    XCTAssertTrue(moves.count == 6, "Move count is not 6.")
    XCTAssertTrue(moveHasBeenFound(moves, from: .d8, to: .d6), "d8d6 not found.")
    XCTAssertTrue(moveHasBeenFound(moves, from: .d8, to: .h4), "d8h4 not found.")
    XCTAssertFalse(moveHasBeenFound(moves, from: .d8, to: .c7), "d8c7 found, square is blocked.")
    XCTAssertFalse(moveHasBeenFound(moves, from: .d8, to: .b6), "d8b6 found, square is blocked.")
  }
  
  func testWhiteKingMovesAfterE4E5D4D5() {
    let pos = CTPosition(fen: "rnbqkbnr/ppp2ppp/8/3pp3/3PP3/8/PPP2PPP/RNBQKBNR w KQkq - 4 3")
    let gen = CTMoveGenerator(position: pos)
    
    let moves = gen.generateKingMoves(.white)
    
    XCTAssertTrue(moves.count == 2, "Move count is not 2.")
    XCTAssertTrue(moveHasBeenFound(moves, from: .e1, to: .d2), "e1d2 not found.")
    XCTAssertTrue(moveHasBeenFound(moves, from: .e1, to: .e2), "e1e2 not found.")
    XCTAssertFalse(moveHasBeenFound(moves, from: .e1, to: .d1), "e1d1 found, square is blocked.")
    XCTAssertFalse(moveHasBeenFound(moves, from: .e1, to: .f2), "e1f2 found, square is blocked.")
  }
  
  func testBlackKingMovesAfterE4E5D4D5() {
    let pos = CTPosition(fen: "rnbqkbnr/ppp2ppp/8/3pp3/3PP3/8/PPP2PPP/RNBQKBNR w KQkq - 4 3")
    let gen = CTMoveGenerator(position: pos)
    
    let moves = gen.generateKingMoves(.black)
    
    XCTAssertTrue(moves.count == 2, "Move count is not 2.")
    XCTAssertTrue(moveHasBeenFound(moves, from: .e8, to: .d7), "e8d7 not found.")
    XCTAssertTrue(moveHasBeenFound(moves, from: .e8, to: .e7), "e8e7 not found.")
    XCTAssertFalse(moveHasBeenFound(moves, from: .e8, to: .d8), "e8d8 found, square is blocked.")
    XCTAssertFalse(moveHasBeenFound(moves, from: .e8, to: .f7), "e8f7 found, square is blocked.")
  }
  
  func testWhiteCastlingIsFound() {
    let pos = CTPosition(fen: "r3k2r/pppbqppp/2np1n2/2b1p3/2B1P3/2NP1N2/PPPBQPPP/R3K2R w KQkq - 14 8")
    let gen = CTMoveGenerator(position: pos)
    
    let moves = gen.generateKingMoves(.white)
    
    XCTAssertTrue(moveHasBeenFound(moves, from: .e1, to: .g1), "Short Castling not found.")
    XCTAssertTrue(moveHasBeenFound(moves, from: .e1, to: .c1), "Long Castling not found.")
  }
  
  func testBlackCastlingIsFound() {
    let pos = CTPosition(fen: "r3k2r/pppbqppp/2np1n2/2b1p3/2B1P3/2NP1N2/PPPBQPPP/R3K2R w KQkq - 14 8")
    let gen = CTMoveGenerator(position: pos)
    
    let moves = gen.generateKingMoves(.black)
    
    XCTAssertTrue(moveHasBeenFound(moves, from: .e8, to: .g8), "Short Castling not found.")
    XCTAssertTrue(moveHasBeenFound(moves, from: .e8, to: .c8), "Long Castling not found.")
  }
  
  func testIsSquareUnderAttackForWhite() {
    let pos = CTPosition(fen: "r3k2r/pppbqppp/2np1n2/2b1p3/2B1P3/2NP1N2/PPPBQPPP/R3K2R w KQkq - 14 8")
    let gen = CTMoveGenerator(position: pos)
    
    let attackingMoves = gen.attackingMovesForSquare(.d4, attackSide: .black)
    
    XCTAssertTrue(attackingMoves.count > 0, "d4 should be under attack.")
  }
  
  func testWhitePawnCannotJumpOverKnightAfterG1F3() {
    let pos = CTPosition()
    let gen = CTMoveGenerator(position: pos)
    
    let _ = pos.makeMove(from: .g1, to: .f3)
    let _ = pos.makeMove(from: .b8, to: .c6)
    
    let moves = gen.generateWhitePawnMoves()
    
    XCTAssertFalse(moveHasBeenFound(moves, from: .f2, to: .f4), "f2f4 has been found.")
  }
  
  func testBlackPawnCannotJumpOverKnightAfterB8C6() {
    let pos = CTPosition()
    let gen = CTMoveGenerator(position: pos)
    
    let _ = pos.makeMove(from: .g1, to: .f3)
    let _ = pos.makeMove(from: .b8, to: .c6)
    let _ = pos.makeMove(from: .h2, to: .h3)
    
    let moves = gen.generateBlackPawnMoves()
    
    XCTAssertFalse(moveHasBeenFound(moves, from: .c7, to: .c5), "c7c5 has been found.")
  }
  
  fileprivate func moveHasBeenFound(_ moveList: [CTMove], from: CTSquare, to: CTSquare) -> Bool {
    let foundMoves = moveList.filter { (move: CTMove) -> Bool in
      if move.from == from && move.to == to {
        return true
      }
      return false
    }
    return foundMoves.count == 1
  }
}
