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
  
  var didLoginSuccessfully: (() -> Void)?
  
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
    let dispatchGroup = DispatchGroup()
    let queue = DispatchQueue(label: "authentication")
    var authError: Error?
    let userRepo = UserRepo()
    
    dispatchGroup.enter()
    authenticationRepoType?.authenticate()
    authenticationRepoType?.receivedAccessTokenHandler = { error in
      defer {
        dispatchGroup.leave()
      }
      guard error == nil else {
        authError = error
        print("error getting access token: ", error!)
        return
      }
    }
    
    dispatchGroup.enter()
    userRepo.getMe(completion: { [weak self] (result) in
      defer {
        dispatchGroup.leave()
      }
      switch result {
      case let .success(user):
        UserSession.saveUser(user, completion: { (error) in
          guard error == nil else {
            authError = error
            print("error saving user: ", error!)
            return
          }
        })
      case let .failure(error):
        print("error getting user: ", error)
      }
    })

    dispatchGroup.notify(queue: queue) {
      if let error = authError {
        print("DispatchQueue failed. Error: ", error)
      }
      CustomHUD.showSuccess(title: "Success",
                            details: "You are now logged in",
                            delay: 1.5) { [weak self] _ in
                              print("All done. logged in and saved user session")
                              self?.didLoginSuccessfully?()
                              self?.dismiss(animated: true)
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

