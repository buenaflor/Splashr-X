//
//  PresentableAnimatorTarget.swift
//  Splashr-X
//
//  Created by Gino on 05.06.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

/// A target is a ViewController that is meant to be dismissed with a transition
protocol PresentableAnimatorTarget: class, TransitionAnimationDurationCompatible {
  func dismissViewController(animated: Bool)
  var presentedView: UIView { get }
}

extension LoginViewController: PresentableAnimatorTarget {
  
  func dismissViewController(animated: Bool) {
    
    isBeingDismissedManually = true
    dismiss(animated: animated)
  }
  
  var presentedView: UIView {
    return self.view
  }
}

extension AddToCollectionsViewController: PresentableAnimatorTarget {
  func dismissViewController(animated: Bool) {

    isBeingDismissedManually = true
    dismiss(animated: animated)
  }
  
  var presentedView: UIView {
    return self.view
  }
}


