//
//  CTMove.swift
//  ChessToolkit
//
//  Created by Thorsten Klusemann on 16.07.15.
//  Copyright (c) 2015 Thorsten Klusemann. All rights reserved.
//

import Foundation

struct CTMove : Equatable, CustomStringConvertible {
  
  var piece: CTPiece
  var from: CTSquare
  var to: CTSquare
  var captured: CTPiece
  var enPassant: Bool = false
  var promotionPiece: CTPiece
  var castlingRightsBeforeMove: CTCastlingRights
  var check: Bool
  var moveNumber: Int
  
  var castling: Bool {
    if piece == .whiteKing && from == .e1 {
      if to == .c1 || to == .g1 {
        return true
      }
      return false
    }
    if piece == .blackKing && from == .e8 {
      if to == .c8 || to == .g8 {
        return true
      }
    }
    return false
  }
  
  var promotion: Bool {
    if piece == .whitePawn && to.rawValue >= 110 && to.rawValue <= 117 {
      return true
    }
    if piece == .blackPawn && to.rawValue >= 26 && to.rawValue <= 33 {
      return true
    }
    
    return false
  }
  
  var description : String {
    return "\(from.toRowAndColumn()) - \(to.toRowAndColumn())"
  }
  
  init(piece: CTPiece, from: CTSquare, to: CTSquare, captured: CTPiece, enPassant: Bool, promotionPiece: CTPiece, castlingRights: CTCastlingRights, moveNumber: Int) {
    self.piece = piece
    self.from = from
    self.to = to
    self.captured = captured
    self.enPassant = enPassant
    self.promotionPiece = promotionPiece
    self.castlingRightsBeforeMove = castlingRights
    self.check = false
    self.moveNumber = moveNumber
  }
  
  func toNotation(_ style: CTMoveNotationStyle) -> String {
    if castling {
      var notation = "O-O"
      if to == .c8 || to == .c1 {
        notation += "-O"
      }
      if check {
        notation += "+"
      }
      return notation
    }
    
    let pieceNotation = piece.toPGN()
    
    var connector = ""
    var fromNotation = ""
    var checkNotation = ""
    var promotionNotation = ""
    if style == .long {
      connector = captured != .empty ? "x" : "-"
      fromNotation = "\(from.toString())"
    } else {
      if captured != .empty {
        connector = "x"
        if pieceNotation == "" {
          fromNotation = from.toString()[0]
        }
      }
    }
    
    if promotionPiece != .empty {
      promotionNotation = promotionPiece.toPGN()
    }
    
    if check {
      checkNotation = "+"
    }
    
    let notation = "\(pieceNotation)\(fromNotation)\(connector)\(to.toString())\(promotionNotation)\(checkNotation)"
    
    return notation
  }
  
  mutating func setCheck(_ check: Bool) {
    self.check = check
  }
}

func ==(lhs: CTMove, rhs: CTMove) -> Bool {
  return lhs.from == rhs.from && lhs.to == rhs.to && lhs.piece == rhs.piece && lhs.promotionPiece == rhs.promotionPiece
}
