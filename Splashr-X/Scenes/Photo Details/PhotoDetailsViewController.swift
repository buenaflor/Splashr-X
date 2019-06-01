//
//  PhotoDetailsViewController.swift
//  Splashr-X
//
//  Created by Gino on 30.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

class PhotoDetailsViewController: UIViewController {
  
  var photo: UIImage?
  var details: PhotoTableViewItem?
  
  @IBOutlet weak var imageZoomView: ImageZoomScrollView!
  
  override func viewDidLoad() {
    super.viewDidLoad()

    configureViewController()
    configurePhotoImageView()
    configureDismissGesture()
  }
  
  /// Sets the navifgation bar appearance
  fileprivate func setNavigationBarAppearance() {
    let downloadItem = UIBarButtonItem(image: #imageLiteral(resourceName: "arrow_down"), style: .plain, target: self, action: #selector(downloadItemTapped(_:)))
    navigationItem.rightBarButtonItem = downloadItem
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.isTranslucent = true
    navigationController?.navigationBar.tintColor = .white
  }
  
  /// Configures the ViewController
  fileprivate func configureViewController() {
    view.backgroundColor = .black
    setNavigationBarAppearance()
  }
  
  /// Configures the photo imageView and the scrollView
  fileprivate func configurePhotoImageView() {
    imageZoomView.imageView.image = photo
    imageZoomView.configure(topBarHeight: topbarHeight)
    imageZoomView.imageView.center.y = CGFloat(UIScreen.main.bounds.height / 2) - topbarHeight + 10
  }
  
  /// Triggered when the download item is tapped
  @objc private func downloadItemTapped(_ sender: UIBarButtonItem) {
    guard let photo = photo else {
      print("error, image is not available?!")
      CustomHUD.showError(title: "Error", details: "Couldn't save photo")
      return
    }
    let alert = AlertPresenter.savePhotoToLibray { saveToPhotos in
      if saveToPhotos {
        self.savePhotoToAlbum(photo)
      }
    }
    alert.present(in: self)
  }
  
  /// Saves the photo to the local photo library
  fileprivate func savePhotoToAlbum(_ photo: UIImage) {
    PhotoLibraryManager.shared.save(photo)
  }
  
  // MARK: Drag-to-dismiss
  
  private let dismissPanGesture = UIPanGestureRecognizer()
  public var isInteractivelyDismissing: Bool = false
  public weak var transitionController: PhotoDetailsInteractiveDismissTransition? = nil
  
  private func configureDismissGesture() {
    self.view.addGestureRecognizer(self.dismissPanGesture)
    self.dismissPanGesture.addTarget(self, action: #selector(dismissPanGestureDidChange(_:)))
  }
  
  var previousViewControllerr: UIViewController?
  @objc private func dismissPanGestureDidChange(_ gesture: UIPanGestureRecognizer) {
    // Decide whether we're interactively-dismissing, and notify our navigation controller.
    switch gesture.state {
    case .began:
      let viewControllers = navigationController?.viewControllers
      let count = viewControllers?.count ?? 0
      if count > 1 {
        if let vc = viewControllers?[count - 2] as? PhotosViewController {
          previousViewControllerr = vc
        }
      }
      isInteractivelyDismissing = true
      navigationController?.popViewController(animated: true)
    case .cancelled, .failed, .ended:
      previousViewControllerr?.title = ""
      isInteractivelyDismissing = false
    case .changed, .possible:
      break
    @unknown default:
      break
    }
    
    // We want to update our transition controller, too!
    self.transitionController?.didPanWith(gestureRecognizer: gesture)
  }

}
