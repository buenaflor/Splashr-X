//
//  PhotosViewController+ActionHandlers.swift
//  Splashr-X
//
//  Created by Gino on 30.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

extension PhotosViewController {
  
  /// Likes a user photo but checks if user is logged in first
  func likePhoto(_ button: UIButton, _ photo: PhotoTableViewItem) {

  }
  
  /// Sends/Share the photo based on the actions
  func sendPhoto(_ button: UIButton, _ photo: PhotoTableViewItem) {
    
  }
  
  /// Download the photo at the indexPath
  func downloadPhoto(_ button: UIButton, _ photo: PhotoTableViewItem) {
    
  }
  
  /// Bookmarks the photo but checks if user is logged in first
  func bookmarkPhoto(_ button: UIButton, _ photo: PhotoTableViewItem) {
    
  }
  
  /// Shows the photo details with an animation
  func showPhotoDetails(_ imageView: UIImageView, _ details: PhotoTableViewItem, _ cell: UITableViewCell) {
    guard let photo = imageView.image else {
      print("Error: photo is nil, couldn't load/present details")
      return
    }
    
    // Scroll to the row so we don't come across navigation bar transition bugs
    if let indexPath = tableView.indexPath(for: cell) {
      tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    
    title = ""
    tappedCell = cell
    let scene = Scene.photoDetails(photo, details)
    SceneCoordinator.shared.transition(to: scene)
  }
}
