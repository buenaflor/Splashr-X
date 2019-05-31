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
    imageZoomView.isHidden = true
  }
  
  func transitionDidEnd() {
    imageZoomView.isHidden = false
  }
  
  var referenceImage: UIImage? {
    return imageZoomView.imageView.image
  }
  
  var imageFrame: CGRect? {
    let rect = CGRect.makeRect(aspectRatio: imageZoomView.imageView.image!.size, insideRect: imageZoomView.frame)
    return rect
  }
}
