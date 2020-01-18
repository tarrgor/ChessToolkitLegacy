//
//  ChessToolkitUIError.swift
//  ChessToolkitUI2-macOS
//
//  Created by Thorsten Klusemann on 12.01.20.
//

import Foundation

enum PieceSetError : Error {
  case imageNotFound(name: String)
}
