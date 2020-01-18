//
//  PieceSet.swift
//  ChessToolkitUI2-macOS
//
//  Created by Thorsten Klusemann on 12.01.20.
//

import AppKit
import ChessToolkit

class PieceSet {
  
  let frameworkBundle = Bundle(identifier: "de.tklusemann.ChessToolkitUI2-macOS")
  
  let name: String
  
  init(name: String) {
    self.name = name
  }

  func image(for piece: CTPiece) throws -> NSImage {
    let imageName = "\(name)/\(piece.description)"
    guard let image = frameworkBundle?.image(forResource: imageName) else {
      throw PieceSetError.imageNotFound(name: imageName)
    }
    return image
  }
  
}
