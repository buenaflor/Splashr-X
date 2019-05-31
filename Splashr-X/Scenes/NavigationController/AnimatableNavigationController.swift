//
//  AnimatableNavigationController.swift
//  Splashr-X
//
//  Created by Gino on 31.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

/// Adds support for custom navigation transitions
class AnimatableNavigationController: UINavigationController {
  
  fileprivate var currentAnimationTransition: UIViewControllerAnimatedTransitioning? = nil
  
  public override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  /// The tab bar should be hidden if a PhotoDetailVC is anywhere in the stack.
  public var shouldTabBarBeHidden: Bool {
    let photoDetailsInNavStack = self.viewControllers.contains(where: { (vc) -> Bool in
      return vc.isKind(of: PhotoDetailsViewController.self)
    })

    let isPoppingFromPhotoDetail =
      (self.currentAnimationTransition?.isKind(of: PhotoDetailsPopTransition.self) ?? false)

    if isPoppingFromPhotoDetail {
      return false
    } else {
      return photoDetailsInNavStack
    }
  }
}

extension AnimatableNavigationController: UINavigationControllerDelegate {

  func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    var result: UIViewControllerAnimatedTransitioning?
    
    if let photoDetailsVC = toVC as? PhotoDetailsViewController, operation == .push {
      result = PhotoDetailsPushTransition(fromDelegate: fromVC, toPhotoDetailsVC: photoDetailsVC)
    } else if let photoDetailsVC = fromVC as? PhotoDetailsViewController, operation == .pop {
      result = PhotoDetailsPopTransition(toDelegate: toVC, fromPhotoDetailsVC: photoDetailsVC)
    }
    
    self.currentAnimationTransition = result
    return result
  }

  
  func navigationController(
    _ navigationController: UINavigationController,
    interactionControllerFor animationController: UIViewControllerAnimatedTransitioning
    ) -> UIViewControllerInteractiveTransitioning? {
    return self.currentAnimationTransition as? UIViewControllerInteractiveTransitioning
  }
  
   func navigationController(
    _ navigationController: UINavigationController,
    didShow viewController: UIViewController,
    animated: Bool
    ) {
    self.currentAnimationTransition = nil
  }
}
