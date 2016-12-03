//
//  NSColor+Extension.swift
//  ChessToolkit
//
//  Created by Thorsten Klusemann on 02.07.15.
//  Copyright (c) 2015 Thorsten Klusemann. All rights reserved.
//

import UIKit

extension UIColor {
  
  static func colorFromHexString(_ hex:String) -> UIColor {
    let rgbValue = UnsafeMutablePointer<UInt32>.allocate(capacity: 1)
    
    let scanner = Scanner(string: hex)
    if hex[0] == "#"  {
      scanner.scanLocation = 1
    }
    scanner.scanHexInt32(rgbValue)
    
    let cval = rgbValue.pointee
    rgbValue.deinitialize()
    
    let color = UIColor(red: CGFloat(((cval & 0xFF0000) >> 16)) / 255.0,
      green: CGFloat(((cval & 0xFF00) >> 8)) / 255.0,
      blue: CGFloat(cval & 0xFF) / 255.0, alpha: 1.0)
    
    return color
  }
  
}
