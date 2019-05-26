//
//  SceneCoordinator.swift
//  Splashr
//
//  Created by Giancarlo Buenaflor on 02.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

///Scene coordinator, manage scene navigation and presentation.
class SceneCoordinator: NSObject, SceneCoordinatorType {
  
  static var shared: SceneCoordinator!
  
  fileprivate var window: UIWindow
  fileprivate var currentViewController: UIViewController {
    didSet {
      currentViewController.navigationController?.delegate = self
      currentViewController.tabBarController?.delegate = self
    }
  }
  
  required init(window: UIWindow) {
    self.window = window
    if window.rootViewController == nil {
      currentViewController = UIViewController()
    } else {
      currentViewController = window.rootViewController!
    }
  }
  
  static func actualViewController(for viewController: UIViewController) -> UIViewController {
    var controller = viewController
    if let tabBarController = controller as? UITabBarController {
      guard let selectedViewController = tabBarController.selectedViewController else {
        return tabBarController
      }
      controller = selectedViewController
      
      return actualViewController(for: controller)
    }
    
    if let navigationController = viewController as? UINavigationController {
      controller = navigationController.viewControllers.first!
      
      return actualViewController(for: controller)
    }
    return controller
  }
  
  func transition(to scene: TargetScene) {
    
    switch scene.transition {
    case let .tabBar(tabBarController):
      guard let selectedViewController = tabBarController.selectedViewController else {
        print("Selected view controller doesn't exists")
        return
      }
      currentViewController = SceneCoordinator.actualViewController(for: selectedViewController)
      window.rootViewController = tabBarController
    case let .root(viewController):
      currentViewController = SceneCoordinator.actualViewController(for: viewController)
      window.rootViewController = viewController
    case let .push(viewController):
      guard let navigationController = currentViewController.navigationController else {
        print("Can't push a view controller without a current navigation controller")
        return
      }
      
      navigationController.pushViewController(SceneCoordinator.actualViewController(for: viewController), animated: true)
    case let .present(viewController):
      currentViewController.present(viewController, animated: true)
      currentViewController = SceneCoordinator.actualViewController(for: viewController)
    case let .alert(viewController):
      currentViewController.present(viewController, animated: true)
    }
  }
  
  func updateCurrentViewController(_ viewController: UIViewController) {
    self.currentViewController = viewController
  }
  
  func pop(animated: Bool) {
    
    if let presentingViewController = currentViewController.presentingViewController {
      currentViewController.dismiss(animated: animated) {
        self.currentViewController = SceneCoordinator.actualViewController(for: presentingViewController)
      }
    }
    else if let navigationController = currentViewController.navigationController {
      guard navigationController.popViewController(animated: animated) != nil else {
        print("can't navigate back from \(currentViewController)")
        return
      }
      
      currentViewController = SceneCoordinator.actualViewController(for: navigationController.viewControllers.last!)
      
    } else {
      print("Not a modal, no navigation controller: can't navigate back from \(currentViewController)")
    }
  }
}

// MARK: - UINavigationControllerDelegate

extension SceneCoordinator: UINavigationControllerDelegate {
  func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
    currentViewController = SceneCoordinator.actualViewController(for: viewController)
  }
}

// MARK: - UITabBarControllerDelegate

extension SceneCoordinator: UITabBarControllerDelegate {
  func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController)  {
    currentViewController = SceneCoordinator.actualViewController(for: viewController)
  }
}
