//
//  CGFloat+scaleAndShift.swift
//  Splashr-X
//
//  Created by Gino on 31.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

extension CGFloat {
  /// Returns the value, scaled-and-shifted to the targetRange.
  /// If no target range is provided, we assume the unit range (0, 1)
  static func scaleAndShift(
    value: CGFloat,
    inRange: (min: CGFloat, max: CGFloat),
    toRange: (min: CGFloat, max: CGFloat) = (min: 0.0, max: 1.0)
    ) -> CGFloat {
    assert(inRange.max > inRange.min)
    assert(toRange.max > toRange.min)
    
    if value < inRange.min {
      return toRange.min
    } else if value > inRange.max {
      return toRange.max
    } else {
      let ratio = (value - inRange.min) / (inRange.max - inRange.min)
      return toRange.min + ratio * (toRange.max - toRange.min)
    }
  }
}
