//
//  CGSize+pixelSize.swift
//  Splashr-X
//
//  Created by Gino on 31.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

extension CGSize {
  /// Scales up a point-size CGSize into its pixel representation.
  var pixelSize: CGSize {
    let scale = UIScreen.main.scale
    return CGSize(width: self.width * scale, height: self.height * scale)
  }
}
