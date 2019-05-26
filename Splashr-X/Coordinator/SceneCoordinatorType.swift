//
//  SceneCoordinatorType.swift
//  Splashr
//
//  Created by Giancarlo Buenaflor on 02.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

protocol SceneCoordinatorType {
  init(window: UIWindow)
  
  func transition(to scene: TargetScene)
  func pop(animated: Bool)
}
