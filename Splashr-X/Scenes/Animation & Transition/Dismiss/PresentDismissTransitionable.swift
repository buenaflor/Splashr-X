//
//  PresentTransitionable.swift
//  Splashr-X
//
//  Created by Gino on 05.06.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

/// Conform to this protocol if you want your ViewController to be
/// Presentable with transitions
protocol PresentDismissTransitionable: class {
  var presentableAnimator: PresentableAnimatorType { get }
  var presentDismissTransitionableDependencies: PresentDismissTransitionableDependencies? { get set }
}
