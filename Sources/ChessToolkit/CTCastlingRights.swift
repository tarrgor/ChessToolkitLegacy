//
//  CTCastlingRights.swift
//  ChessToolkit
//
//  Created by Thorsten Klusemann on 13.06.15.
//  Copyright (c) 2015 Thorsten Klusemann. All rights reserved.
//

import Foundation

public struct CTCastlingRights {
  var _whiteCanCastleShort: Bool
  var _whiteCanCastleLong: Bool
  var _blackCanCastleShort: Bool
  var _blackCanCastleLong: Bool
  
  public var whiteCanCastleShort: Bool {
    get {
      return _whiteCanCastleShort
    }
    set {
      _whiteCanCastleShort = newValue
    }
  }
  
  public var whiteCanCastleLong: Bool {
    get {
      return _whiteCanCastleLong
    }
    set {
      _whiteCanCastleLong = newValue
    }
  }
  
  public var blackCanCastleShort: Bool {
    get {
      return _blackCanCastleShort
    }
    set {
      _blackCanCastleShort = newValue
    }
  }
  
  public var blackCanCastleLong: Bool {
    get {
      return _blackCanCastleLong
    }
    set {
      _blackCanCastleLong = newValue
    }
  }
  
  init() {
    self.init(whiteCanCastleShort: true, whiteCanCastleLong: true, blackCanCastleShort: true, blackCanCastleLong: true)
  }
  
  init(whiteCanCastleShort: Bool, whiteCanCastleLong: Bool, blackCanCastleShort: Bool, blackCanCastleLong: Bool) {
    self._whiteCanCastleShort = whiteCanCastleShort
    self._whiteCanCastleLong = whiteCanCastleLong
    self._blackCanCastleShort = blackCanCastleShort
    self._blackCanCastleLong = blackCanCastleLong
  }
}