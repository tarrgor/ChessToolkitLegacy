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
    setupViewConfiguration()
    setupScene()
  }
  
  required public init?(coder: NSCoder) {
    super.init(coder: coder)
    setupViewConfiguration()
    setupScene()
  }

  func setupViewConfiguration() {
    showsDrawCount = true
    showsNodeCount = true
    showsFPS = true
    showsQuadCount = true
  }
  
  func setupScene() {
    let scene = ChessBoardScene(size: self.bounds.size)
    let boardConfiguration = BoardConfiguration()
    scene.nodeBuilder = NodeBuilder(scene: scene, boardConfiguration: boardConfiguration)
    presentScene(scene)
  }
}
