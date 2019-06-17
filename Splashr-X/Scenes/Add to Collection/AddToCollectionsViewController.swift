//
//  AddToCollectionsViewController.swift
//  Splashr-X
//
//  Created by Gino on 04.06.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

class AddToCollectionsViewController: UIViewController {
  
  @IBOutlet weak var photoImageView: UIImageView! {
    didSet {
      photoImageView
        .apply(.cornered)
        .apply(.fill)
    }
  }
  
  /// Literally a collection view that represents Unsplash collections
  @IBOutlet weak var collectionView: UICollectionView!
  
  var photo: UIImage?
  
  var isBeingDismissedManually = true
  var presentDismissTransitionableDependencies: PresentDismissTransitionableDependencies? {
    didSet {
      transitioningDelegate = presentDismissTransitionableDependencies?.delegate
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureViewController()
    configureViews()
  }
  
  fileprivate func configureViewController() {
    let panGesture = UIPanGestureRecognizer(target: self, action: #selector(dismissPanGesture(_:)))
    view.addGestureRecognizer(panGesture)
  }
  
  fileprivate func configureViews() {
    photoImageView.image = photo
  }
  
  // MARK: - Button Action
    
  @IBAction func dismissViewController(_ sender: UIButton) {
    isBeingDismissedManually = true
    dismiss(animated: true, completion: nil)
  }
  
  // MARK: - Animator
  
  lazy var presentableAnimator: PresentableAnimatorType = {
    let animator = PresentableAnimator(target: self, dependencies: presentDismissTransitionableDependencies)
    return animator
  }()
  
  @objc func dismissPanGesture(_ sender: UIPanGestureRecognizer) {
    presentableAnimator.updatePresentedView(panGestureRecognizer: sender)
  }
  
}
