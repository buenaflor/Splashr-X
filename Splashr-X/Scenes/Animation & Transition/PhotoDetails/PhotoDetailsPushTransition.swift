//
//  PhotoDetailsPushTransition.swift
//  Splashr-X
//
//  Created by Gino on 30.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

class PhotoDetailsPushTransition: NSObject, UIViewControllerAnimatedTransitioning {
  
  fileprivate let fromDelegate: PhotoDetailsTransitionAnimatorDelegate
  fileprivate let photoDetailsVC : PhotoDetailsViewController
  
  fileprivate let transitionImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.apply(.fill)
    imageView.accessibilityIgnoresInvertColors = true
    return imageView
  }()
  
  init?(fromDelegate: Any, toPhotoDetailsVC photoDetailsVC: PhotoDetailsViewController) {
    guard let fromDelegate = fromDelegate as? PhotoDetailsTransitionAnimatorDelegate else {
      return nil
    }
    self.fromDelegate = fromDelegate
    self.photoDetailsVC = photoDetailsVC
  }
  
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 0.38
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    // Build out the animation
    let toView = transitionContext.view(forKey: .to)
    let fromView = transitionContext.view(forKey: .from)
    let fromVCTabBarController = transitionContext.viewController(forKey: .from)?.customTabbarController
    
    let containerView = transitionContext.containerView
    toView?.alpha = 0
    
    [fromView, toView]
      .compactMap { $0 }
      .forEach { containerView.addSubview($0) }
    
    let transitionImage = fromDelegate.referenceImage!
    transitionImageView.image = transitionImage
    transitionImageView.frame = fromDelegate.imageFrame
      ?? PhotoDetailsPushTransition.defaultOffscreenFrameForPresentation(image: transitionImage, forView: toView!)
    let toReferenceFrame = PhotoDetailsPushTransition.calculateZoomInImageFrame(image: transitionImage, forView: toView!)
    containerView.addSubview(self.transitionImageView)
    
    self.fromDelegate.transitionWillStart()
    self.photoDetailsVC.transitionWillStart()
    
    let duration = self.transitionDuration(using: transitionContext)
    let spring: CGFloat = 0.95
    let animator = UIViewPropertyAnimator(duration: duration, dampingRatio: spring) {
      self.transitionImageView.frame = toReferenceFrame
      toView?.alpha = 1
    }
    animator.addCompletion { (position) in
      assert(position == .end)
      
      self.transitionImageView.removeFromSuperview()
      self.transitionImageView.image = nil
      transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
      self.photoDetailsVC.transitionDidEnd()
      self.fromDelegate.transitionDidEnd()
    }
    fromVCTabBarController?.setTabBar(hidden: true,
                                      animated: true,
                                      alongside: animator)

    animator.startAnimation()
  }
  
  /// If no location is provided by the fromDelegate, we'll use an offscreen-bottom position for the image.
  private static func defaultOffscreenFrameForPresentation(image: UIImage, forView view: UIView) -> CGRect {
    var result = PhotoDetailsPushTransition.calculateZoomInImageFrame(image: image, forView: view)
    result.origin.y = view.bounds.height
    return result
  }
  
  /// Because the photoDetailVC isn't laid out yet, we calculate a default rect here.
  // TODO: Move this into PhotoDetailViewController, probably!
  private static func calculateZoomInImageFrame(image: UIImage, forView view: UIView) -> CGRect {
    let rect = CGRect.makeRect(aspectRatio: image.size, insideRect: view.bounds)
    return rect
  }
}
