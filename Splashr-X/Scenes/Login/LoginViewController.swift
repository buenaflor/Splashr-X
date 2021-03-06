//
//  LoginViewController.swift
//  Splashr-X
//
//  Created by Gino on 31.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import UIKit
import AuthenticationServices

class LoginViewController: UIViewController {
  
  var authenticationRepoType: AuthenticationRepoType?
  
  var isBeingDismissedManually = false
  
  var presentDismissTransitionableDependencies: PresentDismissTransitionableDependencies? {
    didSet {
      transitioningDelegate = presentDismissTransitionableDependencies?.delegate
    }
  }
  
  fileprivate let images: [UIImage] = {
    let images: [UIImage] = [#imageLiteral(resourceName: "unsplash7"), #imageLiteral(resourceName: "unsplash5"), #imageLiteral(resourceName: "unsplash4"), #imageLiteral(resourceName: "unsplash3")]
    return images
  }()
  
  @IBOutlet weak var dismissButton: UIButton! {
    didSet {
      dismissButton.setImage(#imageLiteral(resourceName: "dropdown_arrow").withRenderingMode(.alwaysTemplate), for: .normal)
      dismissButton.tintColor = .white
    }
  }
  
  fileprivate var loginViewDataSourceProvider: LoginViewDataSourceProvider<UIImage>?
  
  @IBOutlet weak var loginButton: UIButton! {
    didSet {
      loginButton.apply(.cornered)
    }
  }
  
  @IBOutlet weak var collectionView: UICollectionView! {
    didSet {
      collectionView.register(LoginImagePreviewCollectionViewCell.self)
      collectionView.isScrollEnabled = false
      if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
        layout.itemSize = CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureViewController()
    configureDataSourceProvider()
    executeImageLooping()
  }
  
  deinit {
    timer?.invalidate()
    print("deinitialized")
  }
  
  // MARK: - Configuration
  
  fileprivate func configureViewController() {
    let panGesture = UIPanGestureRecognizer(target: self, action: #selector(dismissPanGesture(_:)))
    view.addGestureRecognizer(panGesture)
  }
  
  /// Configures the data source provider
  fileprivate func configureDataSourceProvider() {
    loginViewDataSourceProvider = LoginViewDataSourceProvider(models: images)
    collectionView.delegate = loginViewDataSourceProvider
    collectionView.dataSource = loginViewDataSourceProvider
  }

  // MARK: - Automatic Scrolling
  
  
  var timer: Timer?
  fileprivate func executeImageLooping() {
    timer = Timer.scheduledTimer(withTimeInterval: 6.0, repeats: true) { [ weak self] (_) in
      self?.scrollToNextImage()
    }
    timer?.fire()
  }
  
  var currentIndex = 0
  fileprivate func scrollToNextImage() {
    if currentIndex == images.count {
      currentIndex = 0
    }
    let indexPath = IndexPath(row: currentIndex, section: 0)
    collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    currentIndex += 1
  }
  
  // MARK: - Animator
  
  lazy var presentableAnimator: PresentableAnimatorType = {
    let animator = PresentableAnimator(target: self, dependencies: presentDismissTransitionableDependencies)
    return animator
  }()
  
  @objc func dismissPanGesture(_ sender: UIPanGestureRecognizer) {
    presentableAnimator.updatePresentedView(panGestureRecognizer: sender)
  }
  
  // MARK: Authentication
  
  fileprivate func authenticate() {
    authenticationRepoType?.authenticate()
    authenticationRepoType?.receivedAccessTokenHandler = { [weak self] error in
      if let error = error {
        print("error getting access token: ", error)
      } else {
        CustomHUD.showSuccess(title: "Success",
                              details: "You are now logged in",
                              delay: 1.5) { _ in
                                self?.dismiss(animated: true)
        }
      }
    }
  }
}

// MARK: Action Handlers

extension LoginViewController {
  
  @IBAction private func loginButtonTapped(_ sender: UIButton) {
    authenticate()
  }
  
  @IBAction func dismissButtonTapped(_ sender: UIButton) {
//    SceneCoordinator.shared.pop(animated: true)
    isBeingDismissedManually = true
    dismiss(animated: true)
  }
}

