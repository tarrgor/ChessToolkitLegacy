//
//  CTChessboardView+tvOS.swift
//  ChessToolkitUI-tvOS
//
//  Created by Thorsten Klusemann on 23.03.18.
//

import UIKit

extension CTChessboardView {
  
  @objc internal func panned(recognizer: UIPanGestureRecognizer) {
    let location = recognizer.location(in: self)
    switch recognizer.state {
    case .began:
      self._panStartLocation = location
      print("Panning began at location \(location)")
    case .changed:
      print("Panning difference \(location.x - self._panStartLocation!.x), \(location.y - self._panStartLocation!.y)")
    case .ended:
      print("Panning ended with difference \(location.x - self._panStartLocation!.x), \(location.y - self._panStartLocation!.y)")
    case .cancelled:
      print("Panning cancelled at location \(location)")
    default:
      print("default")
    }
  }
  
}
