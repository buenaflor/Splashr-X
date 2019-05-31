//
//  PhotosViewController.swift
//  Splashr-X
//
//  Created by Gino on 29.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {
  
  var photosRepoType: PhotosRepoType? {
    didSet {
      configureIsWaitingForConnectivity()
    }
  }
  
  fileprivate var photos: Photos = [] {
    didSet {
      photosViewDataSourceProvider?.reloadAll(photos)
    }
  }
  
  /// Data Source provider -> DataSource, Delegate & PrefetchDataSource
  fileprivate var photosViewDataSourceProvider: PhotosViewDataSourceProvider<Photo>? {
    didSet {
      photosViewDataSourceProvider?.prefetchCollections = { [weak self] in
        self?.fetchPhotos()
      }
      photosViewDataSourceProvider?.likeButtonTappedHandler = { [weak self] button, photo in
        self?.likePhoto(button, photo)
      }
      photosViewDataSourceProvider?.sendButtonTappedHandler = { [weak self] button, photo in
        self?.sendPhoto(button, photo)
      }
      photosViewDataSourceProvider?.downloadButtonTappedHandler = { [weak self] button, photo in
        self?.downloadPhoto(button, photo)
      }
      photosViewDataSourceProvider?.bookmarkButtonTappedHandler = { [weak self] button, photo in
        self?.bookmarkPhoto(button, photo)
      }
      photosViewDataSourceProvider?.photoImageViewTappedHandler = { [weak self] imageView, photo, cell in
        self?.showPhotoDetails(imageView, photo, cell)
      }
    }
  }
  
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
    
    navigationController?.delegate = navigationController as? AnimatableNavigationController
    
    // Fetches the very first page
    fetchPhotos()
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
  
  /// Called if the urlSession is waiting for connectivity
  fileprivate func configureIsWaitingForConnectivity() {
    //    photoRepoType?.isWaitingForConnectivityHandler = { [weak self] (session, task) in
    //      print("waitin for connectivity in photos vc")
    //    }
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
      switch result {
      case let .success(photos):
        self?.isFetchInProgress = false
        
        self?.photos.append(contentsOf: photos)
        self?.currentPage += 1
        
        DispatchQueue.main.async {
          // Load it the first time
          if self?.photosViewDataSourceProvider == nil {
            self?.configureDataSourceProvider()
          }
          self?.tableView.reloadData()
        }
      case let .failure(error):
        self?.isFetchInProgress = false
        print("error: ", error)
      }
    })
  }
}

