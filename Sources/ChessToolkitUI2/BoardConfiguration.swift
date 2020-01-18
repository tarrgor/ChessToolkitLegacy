//
//  BoardConfiguration.swift
//  ChessToolkitUI2-macOS
//
//  Created by Thorsten Klusemann on 18.01.20.
//

import AppKit

struct BoardConfiguration {
  
  var pieceSet = PieceSet(name: "Default")
  var lightSquareColor = NSColor.lightGray
  var darkSquareColor = NSColor.darkGray
  
  init() {
    
  }
  
}
