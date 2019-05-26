//
//  Style.swift
//  Splashr
//
//  Created by Gino on 25.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

struct ViewStyle<T> {
  let style: (T) -> T
}

protocol Stylable {
  init()
}

extension Stylable {
  init(style: ViewStyle<Self>) {
    self.init()
    apply(style)
  }
  
  @discardableResult
  func apply(_ style: ViewStyle<Self>) -> Self {
    return style.style(self)
  }
}

extension UIView: Stylable {}


