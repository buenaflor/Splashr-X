//
//  PhotoDetailsTransitionAnimatorDelegate.swift
//  Splashr-X
//
//  Created by Gino on 31.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

protocol PhotoDetailsTransitionAnimatorDelegate: class {
  
  /// Called just before the transition animation begins
  /// Use this to prepare for the transition
  func transitionWillStart()
  
  /// Called just before the transition animation ends
  /// Use this to clean up after the transition
  func transitionDidEnd()
  
  /// The animator needs a UIImageView for the transition
  /// eg the Photo Details screen should provide a snapshotView of its image
  /// and a collectionView/tableView should do the same for its image views
  var referenceImage: UIImage? { get }
  
  /// The location onscreen for the imageView provided in referenceImageView(for:)
  var imageFrame: CGRect? { get }
  
}
