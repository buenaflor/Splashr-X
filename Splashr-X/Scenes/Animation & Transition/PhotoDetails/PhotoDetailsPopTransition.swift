//
//  PhotoDetailsPopTransition.swift
//  Splashr-X
//
//  Created by Gino on 31.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

class PhotoDetailsPopTransition: NSObject, UIViewControllerAnimatedTransitioning {
  fileprivate let toDelegate: PhotoDetailsTransitionAnimatorDelegate
  fileprivate let photoDetailVC: PhotoDetailsViewController
  
  /// The snapshotView that is animating between the two view controllers.
  fileprivate let transitionImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    imageView.accessibilityIgnoresInvertColors = true
    return imageView
  }()
  
  /// If toDelegate isn't PhotoDetailTransitionAnimatorDelegate, returns nil.
  init?(toDelegate: Any, fromPhotoDetailsVC photoDetailVC: PhotoDetailsViewController) {
    guard let toDelegate = toDelegate as? PhotoDetailsTransitionAnimatorDelegate else {
      return nil
    }
    
    self.toDelegate = toDelegate
    self.photoDetailVC = photoDetailVC
  }
  
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 0.38
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    let fromView = transitionContext.view(forKey: .from)
    let toView = transitionContext.view(forKey: .to)
    let toVCTabBar = transitionContext.viewController(forKey: .to)?.customTabbarController
    let containerView = transitionContext.containerView
    let fromReferenceFrame = photoDetailVC.imageFrame!
    
    let transitionImage = photoDetailVC.referenceImage
    transitionImageView.image = transitionImage
    transitionImageView.frame = photoDetailVC.imageFrame!
    
    [toView, fromView]
      .compactMap { $0 }
      .forEach { containerView.addSubview($0) }
    containerView.addSubview(transitionImageView)
    
    self.photoDetailVC.transitionWillStart()
    self.toDelegate.transitionWillStart()
    
    let duration = self.transitionDuration(using: transitionContext)
    let spring: CGFloat = 0.9
    let animator = UIViewPropertyAnimator(duration: duration, dampingRatio: spring) {
      fromView?.alpha = 0
    }
    animator.addCompletion { (position) in
      assert(position == .end)
      
      self.transitionImageView.removeFromSuperview()
      self.transitionImageView.image = nil
      transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
      self.toDelegate.transitionDidEnd()
      self.photoDetailVC.transitionDidEnd()
    }
    toVCTabBar?.setTabBar(hidden: false,
                          animated: true,
                          alongside: animator)
    animator.startAnimation()
    
    animator.addAnimations {
        let toReferenceFrame = self.toDelegate.imageFrame ??
          PhotoDetailsPopTransition.defaultOffscreenFrameForDismissal(
            transitionImageSize: fromReferenceFrame.size,
            screenHeight: containerView.bounds.height
        )
        self.transitionImageView.frame = toReferenceFrame
      }
  }
  
  /// If we need a "dummy reference frame", let's throw the image off the bottom of the screen.
  /// Photos.app transitions to CGRect.zero, though I think that's ugly.
  static func defaultOffscreenFrameForDismissal(
    transitionImageSize: CGSize,
    screenHeight: CGFloat
    ) -> CGRect {
    return CGRect(
      x: 0,
      y: screenHeight,
      width: transitionImageSize.width,
      height: transitionImageSize.height
    )
  }
}
