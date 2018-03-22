//
//  CTUIConstants.swift
//  ChessToolkit
//
//  Created by Thorsten Klusemann on 03.12.16.
//
//

import Foundation

struct CTUIConstants {
  // MARK: Framework Constants
  
  #if os(iOS)
  static let kFrameworkIdentifier = "org.karrmarr.ChessToolkitUI-iOS"
  #elseif os(tvOS)
  static let kFrameworkIdentifier = "org.karrmarr.ChessToolkitUI-tvOS"
  #endif
  
  static let kFrameworkBundle = Bundle(identifier: kFrameworkIdentifier)!
  
}

