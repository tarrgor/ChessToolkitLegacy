//
//  CTPieceSet.swift
//  ChessToolkit
//
//  Created by Thorsten Klusemann on 06.07.15.
//  Copyright (c) 2015 Thorsten Klusemann. All rights reserved.
//

import UIKit
import SVGKit
import ChessToolkit

class CTPieceSet {
  
  fileprivate let kFileNamePrefix = "FileName."
  
  fileprivate var _configuration: Dictionary<CTPiece, String>!
  fileprivate var _cache = Dictionary<CTPiece, SVGKImage>()
  
  var name: String
  
  // MARK: Initialization
  
  init(name: String) {
    self.name = name
    
    loadConfiguration()
  }
  
  // MARK: Image handling
  
  func imageForPiece(_ piece: CTPiece, size: CGFloat) -> SVGKImage? {
    // Create and return image
    var image: SVGKImage? = nil
    
    if let cachedImg = _cache[piece] {
      image = cachedImg
    } else {
      if let name = _configuration[piece] {
        if let svgImage = SVGKImage(named: "\(name)", in: CTUIConstants.kFrameworkBundle) {
          image = svgImage
          _cache.updateValue(svgImage, forKey: piece)
        } else {
          print("Error while trying to load SVG image.")
        }
      }
    }
    
    if (image?.hasSize != nil) {
      if size != image?.size.width {
        image?.size = CGSize(width: size, height: size)
      }
    }
    
    return image
  }
  
  // MARK: Private methods
  
  fileprivate func loadConfiguration() {
    var config = Dictionary<CTPiece, String>()
    
    let fileName = "PieceSet_\(self.name)"
    let ext = "plist"
    
    if let configPath = CTUIConstants.kFrameworkBundle.path(forResource: fileName, ofType: ext) {
      if let plistFile = NSDictionary(contentsOfFile: configPath) {
        let enumerator = plistFile.keyEnumerator()
        while let key = enumerator.nextObject() as? String {
          let value = plistFile.object(forKey: key)! as! String
          
          let index = kFileNamePrefix.characters.count
          let pieceChar: Character = key[index]
          
          if let piece = CTPiece.fromFEN(pieceChar) {
            config.updateValue(value, forKey: piece)
          } else {
            print("Invalid piece found.")
          }
        }
      }
    } else {
      print("Error opening config file")
    }
    
    self._configuration = config
  }
}
