//
//  TabbarController.swift
//  Splashr-X
//
//  Created by Gino on 30.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
  
  typealias Dependencies = HasPhotosRepo & HasCollectionsRepo
  var dependencies: Dependencies? {
    didSet {
      loadViewControllers()
    }
  }
  
  /// Loads the dependencies and injects them to the VCs
  /// VCs are then added to the Tabbar
  func loadViewControllers() {
    guard let photosRepoType = dependencies?.photosRepoType,
          let collectionsRepoType = dependencies?.collectionsRepoType else {
      print("error creating dependencies, couldn't load tabbar")
      return
    }
    let photosVC = PhotosViewController.instantiate(photosRepoType: photosRepoType)
    let photosTabbarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "heart_outlined"), selectedImage: #imageLiteral(resourceName: "heart_filled"))
    photosVC.tabBarItem = photosTabbarItem

    let collectionsVC = CollectionsViewController.instantiate(collectionsRepoType: collectionsRepoType)
    let collectionsTabbarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "bookmark_outlined"), selectedImage: #imageLiteral(resourceName: "bookmark_filled"))
    collectionsVC.tabBarItem = collectionsTabbarItem
    
    let wrappedPhotosVC = AnimatableNavigationController(rootViewController: photosVC)
    let wrappedCollectionsVC = AnimatableNavigationController(rootViewController: collectionsVC)
    viewControllers = [wrappedPhotosVC, wrappedCollectionsVC]
  }
  
  public var isNavBarHidden: Bool = false

  public var isTabBarHidden: Bool = false
  
  public var shouldTabBarBeSuppressed: Bool {
    guard
      let currentAnimatableNavigationController = self.selectedViewController as? AnimatableNavigationController
      else {
        fatalError()
    }
    return currentAnimatableNavigationController.shouldTabBarBeHidden
  }
  
//  public override var viewControllers: [UIViewController]? {
//    willSet {
//      // Assert that all child view controllers are a LocketNavigationController
//      newValue?.forEach {
//        assert($0.isKind(of: AnimatableNavigationController.self))
//      }
//    }
//  }
}

extension TabBarController {
  
  /// Show or hide the tab bar.
  func setTabBar(hidden: Bool,
                 animated: Bool = true,
                 alongside animator: UIViewPropertyAnimator? = nil) {
    // We don't show the tab bar if the navigation state of the current tab disallows it.
    if !hidden, self.shouldTabBarBeSuppressed {
      return
    }
    
    guard isTabBarOffscreen != hidden else {
      return
    }
    self.isTabBarHidden = hidden
    
    let offsetY = hidden ? tabBar.frame.height : -tabBar.frame.height
    let endFrame = tabBar.frame.offsetBy(dx: 0, dy: offsetY)
    let vc = selectedViewController
    var newInsets: UIEdgeInsets? = vc?.additionalSafeAreaInsets
    let originalInsets = newInsets
    newInsets?.bottom -= offsetY
    
    /// Helper method for updating child view controller's safe area insets.
    func set(childViewController cvc: UIViewController?, additionalSafeArea: UIEdgeInsets) {
      cvc?.additionalSafeAreaInsets = additionalSafeArea
      cvc?.view.setNeedsLayout()
    }
    
    // Update safe area insets for the current view controller before the animation takes place when hiding the bar.
    if
      hidden,
      let insets = newInsets
    {
      set(childViewController: vc, additionalSafeArea: insets)
    }
    
    guard animated else {
      tabBar.frame = endFrame
      tabBar.isHidden = self.isTabBarHidden
      return
    }
    
    /// If the tab bar was previously hidden, we need to un-hide it.
    if self.tabBar.isHidden, !hidden {
      self.tabBar.isHidden = false
    }
    
    // Perform animation with coordination if one is given. Update safe area insets _after_ the animation is complete,
    // if we're showing the tab bar.
    weak var tabBarRef = self.tabBar
    if let animator = animator {
      animator.addAnimations {
        tabBarRef?.frame = endFrame
      }
      animator.addCompletion { (position) in
        let insets = (position == .end) ? newInsets : originalInsets
        if
          !hidden,
          let insets = insets
        {
          set(childViewController: vc, additionalSafeArea: insets)
        }
        if (position == .end) {
          tabBarRef?.isHidden = hidden
        }
      }
    } else {
      UIView.animate(withDuration: 0.3, animations: {
        tabBarRef?.frame = endFrame
      }) { didFinish in
        if !hidden, didFinish, let insets = newInsets {
          set(childViewController: vc, additionalSafeArea: insets)
        }
        tabBarRef?.isHidden = hidden
      }
    }
  }
  
  /// `true` if the tab bar is currently hidden.
  fileprivate var isTabBarOffscreen: Bool {
    return !tabBar.frame.intersects(view.frame)
  }
}

extension UIViewController {
  var customNavigationController: AnimatableNavigationController? {
    return self.navigationController as? AnimatableNavigationController
  }
  
  var customTabbarController: TabBarController? {
    return self.tabBarController as? TabBarController
  }
}
