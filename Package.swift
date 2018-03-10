//
//  Package.swift
//  ChessToolkit
//
//  Created by Thorsten Klusemann on 25.03.17.
//
//

import PackageDescription

let package = Package(
  name: "ChessToolkit",
  exclude: [
    "Sources/ChessToolkitUI", "Sources/*.xcassets", "Sources/*.plist"
  ]
)

