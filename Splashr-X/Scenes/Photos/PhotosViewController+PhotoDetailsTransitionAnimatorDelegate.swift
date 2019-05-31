//
//  PhotosViewController+UINavigationControllerDelegate.swift
//  Splashr-X
//
//  Created by Gino on 30.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

extension PhotosViewController: PhotoDetailsTransitionAnimatorDelegate {
  
  func transitionWillStart() {
    guard let cell = tappedCell as? PhotosViewTableViewCell else {
      return
    }
    cell.photoImageView.isHidden = true
  }
  
  func transitionDidEnd() {
    guard let cell = tappedCell as? PhotosViewTableViewCell else {
      return
    }
    cell.photoImageView.isHidden = false
  }
  
  var referenceImage: UIImage? {
    guard let cell = tappedCell as? PhotosViewTableViewCell else {
      return nil
    }
    
    return cell.photoImageView.image
  }
  
  var imageFrame: CGRect? {
    guard let cell = tappedCell as? PhotosViewTableViewCell else {
      return nil
    }
    // This is the height for the topview that is needed otherwise the view jumps to the top of the cell
    let topViewHeight: CGFloat = 60
    
    let frame: CGRect = .init(x: cell.frame.origin.x, y: cell.frame.origin.y + topViewHeight, width: cell.frame.width, height: cell.photoImageView.frame.height)
    return self.tableView.convert(frame, to: view)
  }
}

