//
//  PresentableAnimator.swift
//  Splashr-X
//
//  Created by Gino on 04.06.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

protocol PresentableAnimatorType {
  var interactor: DismissInteractor? { get set }
  var target: PresentableAnimatorTarget? { get set }
  func updatePresentedView(panGestureRecognizer: UIPanGestureRecognizer)
}

class PresentableAnimator: PresentableAnimatorType {
  
  weak var interactor: DismissInteractor?
  weak var target: PresentableAnimatorTarget?
  
  init(target: PresentableAnimatorTarget?, dependencies: PresentDismissTransitionableDependencies?) {
    self.interactor = dependencies?.interactor
    self.target = target
  }
  
  func updatePresentedView(panGestureRecognizer: UIPanGestureRecognizer) {
    guard let interactor = self.interactor,
          var target = self.target else {
        return
    }
    
    let percentThreshold: CGFloat = 0.3
    let view = target.presentedView
    
    // convert y-position to downward pull progress (percentage)
    let translation = panGestureRecognizer.translation(in: view)
    let verticalMovement = translation.y / view.bounds.height
    let downwardMovement = fmaxf(Float(verticalMovement), 0.0)
    let downwardMovementPercent = fminf(downwardMovement, 1.0)
    let progress = CGFloat(downwardMovementPercent)
    
    switch panGestureRecognizer.state {
    case .began:
      interactor.hasStarted = true
      target.isBeingDismissedManually = false
      target.dismissViewController(animated: true)
    case .changed:
      interactor.shouldFinish = progress > percentThreshold
      interactor.update(progress)
    case .cancelled:
      interactor.hasStarted = false
      interactor.cancel()
    case .ended:
      interactor.hasStarted = false
      interactor.shouldFinish ? interactor.finish() : interactor.cancel()
    default:
      break
    }
  }
}
