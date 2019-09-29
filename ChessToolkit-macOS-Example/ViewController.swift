//
//  ViewController.swift
//  ChessToolkit-macOS-Example
//
//  Created by Thorsten Klusemann on 29.09.19.
//

import Cocoa
import ChessToolkitUI2_macOS

class ViewController: NSViewController {
  
  @IBOutlet weak var chessBoard: ChessBoard!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override var representedObject: Any? {
    didSet {
    // Update the view, if already loaded.
    }
  }


}

