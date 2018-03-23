//
//  CTChessboardView-iOS.swift
//  ChessToolkitUI-iOS
//
//  Created by Thorsten Klusemann on 23.03.18.
//

import UIKit
import ChessToolkit

extension CTChessboardView {
  // MARK: - Touch handling
  
  internal func removePieceImageSubview() {
    self._dragImage?.removeFromSuperview()
    self._dragImage = nil
  }

  open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    if let touch = touches.first {
      let location = touch.location(in: self)
      let rowcol = rowAndColFromLocation(location)
      let row = rowcol.row
      let col = rowcol.column
      
      guard let square = CTSquare.fromRow(row, column: col) else {
        return
      }
      
      let piece = self.position.pieceAt(square)
      if piece != .empty && piece != .invalid {
        if self.markAllPossibleMoves {
          markPossibleSquares(square)
        }
        
        _draggedItem = pieceSet.imageForPiece(piece)
        _dragFromSquare = square
        _draggedPiece = piece
        
        createPieceImageSubview(piece, location: location)
        
        setNeedsDisplay()
      }
    }
  }
  
  open override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    if self._dragImage == nil {
      return
    }
    
    // let lastLocation = _dragLocation
    if let touch = touches.first {
      let location = touch.location(in: self)
      self._dragImage?.center = location
    }
  }
  
  open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    if let touch = touches.first {
      let releaseLocation = touch.location(in: self)
      
      removePieceImageSubview()
      
      let rowcol = rowAndColFromLocation(releaseLocation)
      let row = rowcol.row
      let col = rowcol.column
      
      if let toSquare = CTSquare.fromRow(row, column: col), let fromSquare = _dragFromSquare {
        
        // update CTPosition
        let _ = position.makeMove(from: fromSquare, to: toSquare)
        
      }
      
      _draggedItem = nil
      _dragFromSquare = nil
      _draggedPiece = nil
      
      clearAllMarkings()
      setNeedsDisplay()
    }
  }
  
  open override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    removePieceImageSubview()
    clearAllMarkings()
    setNeedsDisplay()
  }
}
