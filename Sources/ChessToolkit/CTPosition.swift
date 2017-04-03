//
//  CTPosition.swift
//  ChessDB
//
//  Created by Thorsten Klusemann on 11.06.15.
//  Copyright (c) 2015 Thorsten Klusemann. All rights reserved.
//

import Foundation

public final class CTPosition {
  fileprivate var _posData = Array(repeating: (CTPiece).invalid, count: 144)
  fileprivate var _castlingRights = CTCastlingRights()
  fileprivate var _sideToMove : CTSide = .white
  fileprivate var _enPassantSquare : CTSquare?
  fileprivate var _halfMoveClock : Int = 0
  fileprivate var _fullMoveNumber : Int = 1
  fileprivate var _promotionPieceWhite: CTPiece = .whiteQueen
  fileprivate var _promotionPieceBlack: CTPiece = .blackQueen
  
  fileprivate var _moveGenerator: CTMoveGenerator!
  
  fileprivate var _moveHistory = [CTMove]()
  
  public var enPassantSquare: CTSquare? {
    return _enPassantSquare
  }
  
  public var halfMoveClock: Int {
    return _halfMoveClock
  }
  
  public var promotionPieceWhite: CTPiece {
    get {
      return _promotionPieceWhite
    }
    set {
      if newValue == .whiteQueen || newValue == .whiteRook || newValue == .whiteBishop || newValue == .whiteKnight {
        _promotionPieceWhite = newValue
      }
    }
  }
  
  public var promotionPieceBlack: CTPiece {
    get {
      return _promotionPieceBlack
    }
    set {
      if newValue == .blackQueen || newValue == .blackRook || newValue == .blackBishop || newValue == .blackKnight {
        _promotionPieceBlack = newValue
      }
    }
  }
  
  public var castlingRights: CTCastlingRights {
    return _castlingRights
  }
  
  public var sideToMove: CTSide {
    return _sideToMove
  }
  
  public var moveNumber: Int {
    return _fullMoveNumber
  }
  
  public var lastMove: CTMove? {
    return _moveHistory.last
  }
  
  public var moveGenerator: CTMoveGenerator {
    return self._moveGenerator
  }
  
  public var check: Bool {
    var result = false
    let opposite: CTSide = sideToMove == .white ? .black : .white
    let king: CTPiece = sideToMove == .white ? .whiteKing : .blackKing
    
    filterPiece(king) { [weak self] square in
      let attacks = self!._moveGenerator.attackingMovesForSquare(square, attackSide: opposite)
      if attacks.count > 0 {
        result = true
      }
    }
    
    return result
  }
  
  public init() {
    setupInitialPosition()
    
    _moveGenerator = CTMoveGenerator(position: self)
  }
  
  public init(fen: String) {
    setToFEN(fen)
    
    _moveGenerator = CTMoveGenerator(position: self)
  }
  
  public func setupInitialPosition() {
    _posData = CTConstants.kInitialPosition
    _castlingRights = CTCastlingRights()
    _sideToMove = .white
    _enPassantSquare = nil
    _halfMoveClock = 0
    _fullMoveNumber = 1
  }
  
  public func pieceAt(_ square: CTSquare) -> CTPiece {
    return _posData[square.rawValue]
  }
  
  public func setPiece(_ piece: CTPiece, square: CTSquare) {
    _posData[square.rawValue] = piece
  }
  
  public func removePieceAt(_ square: CTSquare) {
    _posData[square.rawValue] = .empty
  }
  
  func setToFEN(_ fen: String) {
    let parser = CTFENParser(fen: fen)
    
    _posData = parser.posData
    _enPassantSquare = parser.enPassantSquare
    _castlingRights = parser.castlingRights
    _sideToMove = parser.sideToMove
    _halfMoveClock = parser.halfMoveClock
    _fullMoveNumber = parser.fullMoveNumber
  }
  
  public func makeMove(from: CTSquare, to: CTSquare, validate: Bool = true, notifications: Bool = true) -> Bool {
    // Validation
    var move = validateMove(from, to: to, validate: validate)
    
    if (move != nil) {
      // Execute move in the position
      let piece = pieceAt(move!.from)
      removePieceAt(move!.from)
      setPiece(piece, square: move!.to)
      
      if move!.castling {
        handleCastling(move!)
      }
      
      if move!.enPassant {
        handleEnPassant(move!)
      }
      
      if move!.promotion {
        handlePromotion(move!)
      }
      
      // Adjust castling flags
      if move!.piece == .whiteKing {
        _castlingRights.whiteCanCastleLong = false
        _castlingRights.whiteCanCastleShort = false
      } else if move!.piece == .blackKing {
        _castlingRights.blackCanCastleLong = false
        _castlingRights.blackCanCastleShort = false
      } else if move!.piece == .whiteRook && move!.from == .a1 {
        _castlingRights.whiteCanCastleLong = false
      } else if move!.piece == .whiteRook && move!.from == .h1 {
        _castlingRights.whiteCanCastleShort = false
      } else if move!.piece == .blackRook && move!.from == .a8 {
        _castlingRights.blackCanCastleLong = false
      } else if move!.piece == .blackRook && move!.from == .h8 {
        _castlingRights.blackCanCastleShort = false
      }
      
      // Set en passant square if needed
      _enPassantSquare = enPassantSquareAfterMove(move!)
      
      // Switch side to move
      _sideToMove = _sideToMove == .white ? .black : .white
      
      // Set check flag if necessary
      move!.setCheck(check)
      
      // Increase full move number after Black move
      if (_sideToMove == .white) {
        _fullMoveNumber += 1
      }
      
      // Save the played move into the history for takeback option
      _moveHistory.append(move!)
      
      // Send notification DidMakeMove
      if notifications {
        let notificationCenter = NotificationCenter.default
        notificationCenter.post(name: Notification.Name(rawValue: CTConstants.kNotificationPositionDidMakeMove),
          object: self, userInfo: [ CTConstants.kUserInfoAttributeMove : CTObjectWrapper<CTMove>(wrappedValue: move!) ])
      }
      
      return true
    } else {
      return false
    }
  }
  
  public func takeBackMove() -> Bool {
    // Get the last move out of history
    if let move = _moveHistory.last {
      // Takeback move in the position
      let piece = move.piece
      removePieceAt(move.to)
      setPiece(piece, square: move.from)
      
      // Castling? Re-Position the rook.
      if move.castling {
        handleTakeBackCastling(move)
      }
      
      // Bring back captured piece if exists
      var captureSquare = move.to
      if move.enPassant {
        captureSquare = move.piece.side() == .white ? move.to.down()! : move.to.up()!
        _enPassantSquare = move.to
      }
      setPiece(move.captured, square: captureSquare)
      
      // Re-Set castling rights
      _castlingRights = move.castlingRightsBeforeMove
      
      // Switch side to move
      _sideToMove = _sideToMove == .white ? .black : .white
      
      // Decrease full move number when White's move was taken back
      if _sideToMove == .black {
        _fullMoveNumber -= 1
      }
      
      // Remove last move from history
      _moveHistory.removeLast()
      
      return true
    }
    
    return false
  }
  
  public func filterPiece(_ piece: CTPiece, action: (CTSquare) -> ()) {
    for square in CTSquare.allSquares {
      if _posData[square.rawValue] == piece {
        action(square)
      }
    }
  }
  
  // MARK: Conversion methods
  
  public func toFEN() -> String {
    let parser = CTFENParser()
    parser.posData = _posData
    parser.castlingRights = _castlingRights
    parser.enPassantSquare = _enPassantSquare
    parser.fullMoveNumber = _fullMoveNumber
    parser.halfMoveClock = _halfMoveClock
    parser.sideToMove = _sideToMove
    
    return parser.fen
  }
  
  // MARK: Private methods
  
  fileprivate func validateMove(_ from: CTSquare, to: CTSquare, validate: Bool) -> CTMove? {
    // Validation
    if (!validate) {
      return CTMoveBuilder.build(self, from: from, to: to)
    }
    
    let moves = _moveGenerator.generateAllMovesForSide(sideToMove)
    let validMoves = moves.filter { [weak self] currentMove in
      if currentMove.promotion {
        if currentMove.from == from && currentMove.to == to && currentMove.promotionPiece == (self?.sideToMove == .white ? self?.promotionPieceWhite : self?.promotionPieceBlack) {
          return true
        }
      } else {
        if currentMove.from == from && currentMove.to == to {
          return true
        }
      }
      
      return false
    }
    return validMoves.count == 1 ? validMoves[0] : nil
  }
  
  fileprivate func handleCastling(_ move: CTMove) {
    switch move.to {
    case .c1:
      removePieceAt(.a1)
      setPiece(.whiteRook, square: .d1)
    case .g1:
      removePieceAt(.h1)
      setPiece(.whiteRook, square: .f1)
    case .c8:
      removePieceAt(.a8)
      setPiece(.blackRook, square: .d8)
    case .g8:
      removePieceAt(.h8)
      setPiece(.blackRook, square: .f8)
    default:
      print("Invalid castling.")
    }
  }
  
  fileprivate func handleEnPassant(_ move: CTMove) {
    let side = move.piece.side()
    if side == .white {
      let target = move.to.down()
      removePieceAt(target!)
    }
    if side == .black {
      let target = move.to.up()
      removePieceAt(target!)
    }
  }
  
  fileprivate func handlePromotion(_ move: CTMove) {
    setPiece(move.promotionPiece, square: move.to)
  }
  
  fileprivate func enPassantSquareAfterMove(_ move: CTMove) -> CTSquare? {
    var epSquare: CTSquare? = nil
    
    if move.piece == .whitePawn {
      if let testSquare = move.to.down()?.down() {
        if testSquare == move.from {
          if let leftTarget = move.to.left() {
            if pieceAt(leftTarget) == .blackPawn {
              epSquare = move.to.down()
            }
          } else if let rightTarget = move.to.right() {
            if pieceAt(rightTarget) == .blackPawn {
              epSquare = move.to.down()
            }
          }
        }
      }
    } else if move.piece == .blackPawn {
      if let testSquare = move.to.up()?.up() {
        if testSquare == move.from {
          if let leftTarget = move.to.left() {
            if pieceAt(leftTarget) == .whitePawn {
              epSquare = move.to.up()
            }
          } else if let rightTarget = move.to.right() {
            if pieceAt(rightTarget) == .whitePawn {
              epSquare = move.to.up()
            }
          }
        }
      }
    }
    return epSquare
  }
  
  fileprivate func handleTakeBackCastling(_ move: CTMove) {
    switch move.to {
    case .g1:
      removePieceAt(.f1)
      setPiece(.whiteRook, square: .h1)
    case .c1:
      removePieceAt(.d1)
      setPiece(.whiteRook, square: .a1)
    case .g8:
      removePieceAt(.f8)
      setPiece(.blackRook, square: .h8)
    case .c8:
      removePieceAt(.d8)
      setPiece(.blackRook, square: .a8)
    default:
      print("Invalid castling.")
    }
  }
}

extension CTPosition: CustomStringConvertible {
  public var description: String {
    var result = ""
    for row in 0...7 {
      for col in 0...7 {
        if let square = CTSquare.fromRow(row, column: col) {
          result += "\(pieceAt(square).description) "
        } else {
          result += "?? "
        }
      }
      result += "\n"
    }
    return result
  }
}








