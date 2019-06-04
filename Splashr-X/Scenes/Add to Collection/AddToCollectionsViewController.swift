//
//  AddToCollectionsViewController.swift
//  Splashr-X
//
//  Created by Gino on 04.06.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

class AddToCollectionsViewController: UIViewController {
  
  var isBeingDismissedManually = true
  
  var presentDismissTransitionableDependencies: PresentDismissTransitionableDependencies? {
    didSet {
      transitioningDelegate = presentDismissTransitionableDependencies?.delegate
    }
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureViewController()
  }
  
  fileprivate func configureViewController() {
    let panGesture = UIPanGestureRecognizer(target: self, action: #selector(dismissPanGesture(_:)))
    view.addGestureRecognizer(panGesture)
  }
  
  // MARK: - Animator
  
  lazy var presentableAnimator: PresentableAnimatorType = {
    let animator = PresentableAnimator(target: self, dependencies: presentDismissTransitionableDependencies)
    return animator
  }()
  
  @objc func dismissPanGesture(_ sender: UIPanGestureRecognizer) {
    presentableAnimator.updatePresentedView(panGestureRecognizer: sender)
  }
  
}
