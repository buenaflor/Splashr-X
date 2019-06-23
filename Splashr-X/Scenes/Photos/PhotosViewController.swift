//
//  PhotosViewController.swift
//  Splashr-X
//
//  Created by Gino on 29.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {
  
  // MARK: - Repositories/Services
  
  var authenticationRepoType: AuthenticationRepoType?
  
  var photosRepoType: PhotosRepoType?
  
  // MARK: - Model
  
  fileprivate var photos: Photos = [] {
    didSet {
      photosViewDataSourceProvider?.reloadAll(photos)
    }
  }
  
  // MARK: - DataSourceProvider
  
  /// Data Source provider -> DataSource, Delegate & PrefetchDataSource
  fileprivate var photosViewDataSourceProvider: PhotosViewDataSourceProvider<Photo>? {
    didSet {
      photosViewDataSourceProvider?.prefetchCollections = { [weak self] in
        self?.fetchPhotos()
      }
      photosViewDataSourceProvider?.likeButtonTappedHandler = { [weak self] button, details in
        self?.likePhoto(button, details)
      }
      photosViewDataSourceProvider?.sendButtonTappedHandler = { [weak self] button, photo in
        self?.sendPhoto(button, photo)
      }
      photosViewDataSourceProvider?.downloadButtonTappedHandler = { [weak self] button, photo in
        self?.downloadPhoto(button, photo)
      }
      photosViewDataSourceProvider?.bookmarkButtonTappedHandler = { [weak self] button, details, photo in
        self?.bookmarkPhoto(button, details, photo)
      }
      photosViewDataSourceProvider?.photoImageViewTappedHandler = { [weak self] imageView, details, cell in
        self?.showPhotoDetails(imageView, details, cell)
      }
    }
  }
  
  let interactor = DismissInteractor()
  
  /// Used for pagination page number
  /// Default is 1 at the start of the app
  fileprivate var currentPage: Int = 1
  
  /// Indicates if our photoCollection is currently being fetched from API
  fileprivate var isFetchInProgress: Bool = false
  
  @IBOutlet weak var tableView: UITableView! {
    didSet {
      tableView.registerNib(PhotosViewTableViewCell.self)
      tableView.register(UITableViewCell.self)
      tableView.tableFooterView = UIView()
    }
  }
  
  // TEMPORARY
  var tappedCell: UITableViewCell?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Fetches the very first page
    fetchPhotos()
    configureIsWaitingForConnectivity()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    // Configures the view controller
    configureViewControllerForAppearance()
  }
    
  /// Configures the view controller when it is about to appear
  fileprivate func configureViewControllerForAppearance() {
    title = "Photos List"
    navigationController?.delegate = navigationController as? AnimatableNavigationController
  }
  
  /// Handles the fetching of the photos
  /// The page number is automatically updated on each fetch
  fileprivate func fetchPhotos() {
    fetchPhotos(byPageNumber: currentPage, orderBy: .popular)
  }
  
  /// Configures the data source provider
  fileprivate func configureDataSourceProvider() {
    photosViewDataSourceProvider = PhotosViewDataSourceProvider(models: photos)
    tableView.delegate = photosViewDataSourceProvider
    tableView.dataSource = photosViewDataSourceProvider
    tableView.prefetchDataSource = photosViewDataSourceProvider
  }
  
  // MARK: - Task Is Waiting For Connectivity
  
  /// Activity Indicator that should animate when the task is waiting
  fileprivate let activityIndicatorView = UIActivityIndicatorView(style: .gray)
  
  /// Called if the urlSession is waiting for connectivity
  fileprivate func configureIsWaitingForConnectivity() {
    activityIndicatorView.center = tableView.center
    tableView.addSubview(activityIndicatorView)
    photosRepoType?.taskIsWaitingForConnectivity({ [weak self] (session, urlSessionTask) in
      DispatchQueue.main.async {
        self?.activityIndicatorView.startAnimating()
      }
    })
  }

}

// MARK: - Fetching implementation

fileprivate extension PhotosViewController {
  
  /// Loads the photos asynchronously with the specified page number and orderBy
  func fetchPhotos(byPageNumber: Int, orderBy: OrderBy) {
    
    // We won't allow another fetch when this is still in progress
    guard !isFetchInProgress else {
      return
    }
    
    isFetchInProgress = true

    photosRepoType?.photos(byPageNumber: byPageNumber, orderBy: orderBy, curated: false, completion: { [weak self] (result) in
      defer {
        DispatchQueue.main.async {
          self?.activityIndicatorView.stopAnimating()
        }
      }
      switch result {
      case let .success(photos):
        self?.isFetchInProgress = false
        
        self?.photos.append(contentsOf: photos)
        self?.currentPage += 1
        
        DispatchQueue.main.async {
          // Load it the first time
          if self?.photosViewDataSourceProvider == nil {
            self?.configureDataSourceProvider()
            self?.tableView.reloadData()
            return
          }
          
          // Reload without TableView changing offset
          var indexPaths: [IndexPath] = []
          let photosCount = self?.photos.count ?? 0
          let fetchedPhotosCount = photos.count
          for index in photosCount - fetchedPhotosCount..<photosCount {
            indexPaths.append(IndexPath(row: index, section: 0))
          }
          let contentOffset = self?.tableView.contentOffset
          self?.tableView.reloadData()
          self?.tableView.contentOffset = contentOffset ?? CGPoint(x: 0, y: 0)
          self?.tableView.layoutIfNeeded()
        }
      case let .failure(error):
        self?.isFetchInProgress = false
        if let httpErrorDescription = error.httpErrorDescription {
          print("Error: ", httpErrorDescription)
        } else {
          print("Error: ", error)
        }
      }
    })
  }
}

extension PhotosViewController: UIViewControllerTransitioningDelegate {
  func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return DismissAnimator()
  }
  
  func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
    return interactor.hasStarted ? interactor : nil
  }
}
