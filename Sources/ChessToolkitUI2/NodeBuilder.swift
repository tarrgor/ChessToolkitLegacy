//
//  NodeBuilder.swift
//  ChessToolkit-iOS
//
//  Created by Thorsten Klusemann on 18.01.20.
//

import Foundation
import SpriteKit
import ChessToolkit

class NodeBuilder {
  
  let pieceSet = PieceSet(name: "Default")
  var scene: SKScene
  var boardConfiguration: BoardConfiguration
  
  var squareSize: CGFloat {
    return scene.size.width > scene.size.height ? scene.size.height / 8 : scene.size.width / 8
  }

  init(scene: SKScene, boardConfiguration: BoardConfiguration) {
    self.scene = scene
    self.boardConfiguration = boardConfiguration
  }
  
  func buildSquareNode(col: Int, row: Int) -> SKNode {
    let color = ((col + row) % 2 == 0) ? boardConfiguration.darkSquareColor : boardConfiguration.lightSquareColor
    let squareNode = SKSpriteNode(color: color, size: CGSize(width: squareSize, height: squareSize))
    squareNode.position = CGPoint(x: CGFloat(col) * squareSize, y: CGFloat(row) * squareSize)
    squareNode.anchorPoint = CGPoint.zero
    return squareNode
  }
  
  func buildPieceNode(piece: CTPiece) -> SKNode {
    let image = try! pieceSet.image(for: piece)
    let texture = SKTexture(image: image)
    let pieceNode = SKSpriteNode(texture: texture)
    pieceNode.position = CGPoint(x: squareSize / 2, y: squareSize / 2)
    return pieceNode
  }

}
