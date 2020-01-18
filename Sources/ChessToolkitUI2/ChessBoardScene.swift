//
//  ChessBoardScene.swift
//  ChessToolkitUI2-macOS
//
//  Created by Thorsten Klusemann on 29.09.19.
//

import Foundation
import SpriteKit
import ChessToolkit

class ChessBoardScene: SKScene {
  
  var nodeBuilder: NodeBuilder?
        
  // Scene is about to be presented by the view
  override func didMove(to view: SKView) {
    self.scaleMode = .aspectFill
    self.backgroundColor = .black
    self.anchorPoint = CGPoint.zero
    buildBoard()
  }
  
  private func buildBoard() {
    guard let builder = nodeBuilder else { return }
    
    for row in 0...7 {
      for col in 0...7 {
        addChild(builder.buildSquareNode(col: col, row: row))
      }
    }
    addChild(builder.buildPieceNode(piece: .blackBishop))
  }
  
}
