//
//  PhotoDetailsViewController+PhotoDetailsTransitionAnimatorDelegate.swift
//  Splashr-X
//
//  Created by Gino on 31.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

extension PhotoDetailsViewController: PhotoDetailsTransitionAnimatorDelegate {
  
  func transitionWillStart() {
    photoImageView.isHidden = true
  }
  
  func transitionDidEnd() {
    photoImageView.isHidden = false
  }
  
  var referenceImage: UIImage? {
    return photoImageView.image
  }
  
  var imageFrame: CGRect? {
    let rect = CGRect.makeRect(aspectRatio: photoImageView.image!.size, insideRect: photoImageView.frame)
    return rect
  }
}
