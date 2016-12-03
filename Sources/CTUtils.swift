//
//  CTUtils.swift
//  ChessToolkit
//
//  Created by Thorsten Klusemann on 10.08.15.
//  Copyright (c) 2015 Thorsten Klusemann. All rights reserved.
//

import Foundation

class CTObjectWrapper<T> {
  var wrappedValue: T
  
  init(wrappedValue: T) {
    self.wrappedValue = wrappedValue
  }
}