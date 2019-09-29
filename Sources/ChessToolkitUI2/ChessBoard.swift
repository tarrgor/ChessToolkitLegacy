//
//  ChessBoard.swift
//  ChessToolkitUI2-macOS
//
//  Created by Thorsten Klusemann on 29.09.19.
//

import Foundation
import SpriteKit

open class ChessBoard: SKView {
     
  public override init(frame frameRect: NSRect) {
    super.init(frame: frameRect)
    setupScene()
  }
  
  required public init?(coder: NSCoder) {
    super.init(coder: coder)
    setupScene()
  }
  
  func setupScene() {
    let scene = ChessBoardScene(size: self.bounds.size)
    presentScene(scene)
  }
}
