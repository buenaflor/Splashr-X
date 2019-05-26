//
//  UIView+AutoLayout.swift
//  Splashr
//
//  Created by Giancarlo Buenaflor on 02.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

extension UIView {
  func add(to view: UIView) -> Self {
    view.addSubview(self)
    return self
  }
}
