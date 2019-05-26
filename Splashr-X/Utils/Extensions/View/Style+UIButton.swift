//
//  Style+UIButton.swift
//  Splashr
//
//  Created by Gino on 25.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

extension ViewStyle where T: UIView {
  static var rounded: ViewStyle<T> {
    return ViewStyle<T> {
      $0.layer.cornerRadius = 10
      return $0
    }
  }
}

extension ViewStyle where T: UIImageView {
  static var fill: ViewStyle<T> {
    return ViewStyle<T> {
      $0.contentMode = .scaleAspectFill
      $0.layer.masksToBounds = true
      return $0
    }
  }

  static var bordered: ViewStyle<T> {
    return ViewStyle<T> {
      $0.layer.borderWidth = 0.2
      $0.layer.borderColor = UIColor.lightGray.cgColor
      return $0
    }
  }
}

