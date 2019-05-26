//
//  SceneTransitionType.swift
//  Splashr
//
//  Created by Giancarlo Buenaflor on 02.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

enum SceneTransitionType {
  // you can extend this to add animated transition types,
  // interactive transitions and even child view controllers!
  
  case root(UIViewController)       // make view controller the root view controller.
  case push(UIViewController)       // push view controller to navigation stack.
  case present(UIViewController)    // present view controller.
  case alert(UIViewController)      // present alert.
  case tabBar(UITabBarController)   // make tab bar controller the root controller.
}
