//
//  CustomHUD.swift
//  Splashr-X
//
//  Created by Gino on 31.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import UIKit
import PKHUD

struct CustomHUD {
  
  static func showSuccess(title: String? = nil, details: String? = nil, delay: TimeInterval = 3, completionHandler: ((Bool) -> Void)? = nil) {
    DispatchQueue.main.async {
      HUD.flash(.labeledSuccess(title: title, subtitle: details),
                delay: delay,
                completion: completionHandler)
    }
  }
  
  static func showError(title: String? = nil, details: String? = nil, delay: TimeInterval = 3, completionHandler: ((Bool) -> Void)? = nil) {
    DispatchQueue.main.async {
      HUD.flash(.labeledError(title: title, subtitle: details),
                delay: delay,
                completion: completionHandler)
    }
  }

}
