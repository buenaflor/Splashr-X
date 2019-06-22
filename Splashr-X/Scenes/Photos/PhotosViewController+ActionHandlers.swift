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
  func likePhoto(_ button: UIButton, _ details: PhotoTableViewItem) {
    Scene.presentLoginFlowIfNeeded(in: self, presentableDismissDependencies: self) { [weak self] in
      guard let id = details.id else {
        print("Error: cannot like, no id available")
        return
      }
      self?.photosRepoType?.likePhoto(id: id, completion: { (error) in
        guard error == nil else {
          print("Error liking photo: ", error!)
          return
        }
        DispatchQueue.main.async {
          button.setImage(#imageLiteral(resourceName: "heart_filled").withRenderingMode(.alwaysTemplate), for: .normal)
          button.tintColor = .red
        }
      })
    }
  }
  
  /// Sends/Share the photo based on the actions
  func sendPhoto(_ button: UIButton, _ photo: UIImage) {
    // set up activity view controller
    let imageToShare = [ photo ]
    let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
    activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
    
    // exclude some activity types from the list (optional)
    activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.saveToCameraRoll ]
    
    // present the view controller
    self.present(activityViewController, animated: true, completion: nil)
  }
  
  /// Download the photo at the indexPath
  func downloadPhoto(_ button: UIButton, _ photo: UIImage) {
    let alert = AlertPresenter.savePhotoToLibray { saveToPhotos in
      if saveToPhotos {
        PhotoLibraryManager.shared.save(photo)
      }
    }
    alert.present(in: self)
  }
  
  /// Bookmarks the photo but checks if user is logged in first
  func bookmarkPhoto(_ button: UIButton, _ details: PhotoTableViewItem, _ photo: UIImage) {
    Scene.presentLoginFlowIfNeeded(in: self, presentableDismissDependencies: self) { [weak self] in
      guard let self = self else { return }
      
      // We are logged in so we can unwrap it
      let user = UserSession.currentUser!
      let collectionsRepo = CollectionsRepo()
      let addToCollectionsVC = AddToCollectionsViewController.instantiate(presentDismissTransitionableDependencies: self, photo: photo, user: user, collectionsRepo: collectionsRepo)
      DispatchQueue.main.async {
        self.present(addToCollectionsVC, animated: true)
      }
    }
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
    
    // Setting an empty title so the back button text is gone in Photo Details
    title = ""
    
    // Assigning the tapped cell so we are aware which cell has been clicked -> used in the animation
    tappedCell = cell
    
    let scene = Scene.photoDetails(photo, details)
    SceneCoordinator.shared.transition(to: scene)
  }
}
