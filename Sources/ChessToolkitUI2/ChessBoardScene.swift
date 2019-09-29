//
//  ChessBoardScene.swift
//  ChessToolkitUI2-macOS
//
//  Created by Thorsten Klusemann on 29.09.19.
//

import Foundation
import SpriteKit

class ChessBoardScene: SKScene {
  
  // Scene is about to be presented by the view
  override func didMove(to view: SKView) {
    self.scaleMode = .aspectFill
    self.backgroundColor = .black
  }
  
}
