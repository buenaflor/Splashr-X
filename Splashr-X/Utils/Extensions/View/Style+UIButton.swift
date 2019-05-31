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

extension ViewStyle where T: UIView {
  static var bordered: ViewStyle<T> {
    return ViewStyle<T> {
      $0.layer.borderWidth = 0.4
      $0.layer.borderColor = UIColor.lightGray.cgColor
      return $0
    }
  }
  
  static var circle: ViewStyle<T> {
    return ViewStyle<T> {
      $0.layer.cornerRadius = $0.frame.width / 2
      $0.clipsToBounds = true
      return $0
    }
  }
  
  static var cornered: ViewStyle<T> {
    return ViewStyle<T> {
      $0.layer.cornerRadius = 7.5
      return $0
    }
  }
}

extension ViewStyle where T: UIImageView {
  static var fill: ViewStyle<T> {
    return ViewStyle<T> {
      $0.contentMode = .scaleAspectFill
      $0.clipsToBounds = true
      return $0
    }
  }
}

