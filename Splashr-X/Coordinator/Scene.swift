//
//  Scene.swift
//  Splashr
//
//  Created by Giancarlo Buenaflor on 02.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

protocol TargetScene {
  var transition: SceneTransitionType { get }
}

enum Scene {
  
  /// The controller that holds all ViewControllers
  case tabBar
  
  /// The details of a photo
  case photoDetails(UIImage, PhotoTableViewItem)
  
  /// The login page
  case login
}

extension Scene: TargetScene {
  var transition: SceneTransitionType {
    switch self {
    case .tabBar:
      let appDependencies = CoreDependencies()
      let tabBar = TabBarController.instantiate(dependencies: appDependencies)
      return .root(tabBar)
    case let .photoDetails(photo, details):
      let photoDetailsVC = PhotoDetailsViewController.instantiate(photo: photo, details: details)
      return .push(photoDetailsVC)
    case .login:
      let loginVC = LoginViewController()
      return .present(loginVC)
    }
  }
}

