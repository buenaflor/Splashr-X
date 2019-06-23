//
//  AddToCollectionsViewController.swift
//  Splashr-X
//
//  Created by Gino on 04.06.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

class AddToCollectionsViewController: UIViewController {
  
  @IBOutlet weak var saveButton: UIButton! {
    didSet {
      saveButton.apply(.rounded)
    }
  }
  
  @IBOutlet weak var photoImageView: UIImageView! {
    didSet {
      photoImageView
        .apply(.rounded)
        .apply(.fill)
    }
  }
  
  /// Literally a collection view that represents Unsplash collections
  @IBOutlet weak var collectionView: UICollectionView! {
    didSet {
      collectionView.registerNib(AddToCollectionsPhotoCollectionCell.self)
      if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: collectionView.frame.height, height: collectionView.frame.height)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
      }
    }
  }
  
  fileprivate var photoCollections: PhotoCollections = [] {
    didSet {
      addToCollectionsViewDataSourceProvider?.reloadAll(photoCollections)
    }
  }
  
  fileprivate var addToCollectionsViewDataSourceProvider: AddToCollectionsViewDataSourceProvider<PhotoCollection>?
  
  /// The username (logged in user) which we will pull the collections from
  var username: String = ""
  var photo: UIImage?
  var photoID: String = ""
  var collectionsRepo: CollectionsRepoType?
  
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
    configureDataSourceProvider()
    fetchCollections(from: username)
  }
  
  /// Configures the data source provider
  fileprivate func configureDataSourceProvider() {
    addToCollectionsViewDataSourceProvider = AddToCollectionsViewDataSourceProvider(models: photoCollections)
    collectionView.delegate = addToCollectionsViewDataSourceProvider
    collectionView.dataSource = addToCollectionsViewDataSourceProvider
  }
  
  fileprivate func fetchCollections(from username: String) {
    collectionsRepo?.collections(withUsername: username, completion: { [weak self] (result) in
      switch result {
      case let .success(collections):
        self?.photoCollections = collections
        DispatchQueue.main.async {
          self?.collectionView.reloadData()
        }
      case let .failure(error):
        print("my error: ", error)
      }
    })
  }
  
  fileprivate func configureViewController() {
    let panGesture = UIPanGestureRecognizer(target: self, action: #selector(dismissPanGesture(_:)))
    view.addGestureRecognizer(panGesture)
  }
  
  fileprivate func configureViews() {
    photoImageView.image = photo
  }
  
  // MARK: - Button Action
  
  @IBAction func saveToSelectedCollections(_ sender: UIButton) {
    guard
      let selectedItemsIndexPaths = addToCollectionsViewDataSourceProvider?.selectedItems,
      selectedItemsIndexPaths.count > 0
    else {
      CustomHUD.showError(title: "Error", details: "No collection has been selected")
      return
    }
    let selectedCollections = selectedItemsIndexPaths.map({ photoCollections[$0.row] })
    let dispatchGroup = DispatchGroup()
    let dispatchQueue = DispatchQueue(label: "Add Photos To Collection")
    var errors: [Error] = []
    for collection in selectedCollections {
      guard let collectionId = collection.id, !photoID.isEmpty else {
        return
      }
      dispatchGroup.enter()
      collectionsRepo?.addPhotoToCollection(withId: collectionId, photoId: photoID, completion: { (result) in
        if case let Result.failure(error) = result {
          errors.append(error)
        }
        dispatchGroup.leave()
      })
    }
    dispatchGroup.notify(queue: dispatchQueue) {
      guard errors.isEmpty else {
        print("errors occured")
        return
      }
      self.dismissViewController(animated: true)
      print("wut finished")
    }
    print("selected ", selectedCollections)
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
