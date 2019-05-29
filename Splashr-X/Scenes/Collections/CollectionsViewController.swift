//
//  ViewController.swift
//  Splashr-X
//
//  Created by Gino on 26.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import UIKit


class CollectionsViewController: UIViewController {
  
  /// CollectionsRepoType is responsible for handling API requests regarding PhotoCollections
  var collectionsRepoType: CollectionsRepoType? {
    didSet {
      configureIsWaitingForConnectivity()
    }
  }
  
  /// Model for this View Controller
  fileprivate var photoCollections: PhotoCollections = [] {
    didSet {
      collectionsViewDataSourceProvider?.reloadAll(photoCollections)
    }
  }
  
  /// Used for pagination page number
  /// Default is 1 at the start of the app
  fileprivate var currentPage: Int = 1
  
  /// Indicates if our photoCollection is currently being fetched from API
  fileprivate var isFetchInProgress: Bool = false
  
  /// Main tableView used for displaying collections
  @IBOutlet weak var tableView: UITableView! {
    didSet {
      tableView.registerNib(CollectionsViewTableViewCell.self)
      tableView.register(UITableViewCell.self)
      tableView.tableFooterView = UIView()
    }
  }
  
  /// Data Source provider -> DataSource, Delegate & PrefetchDataSource
  fileprivate var collectionsViewDataSourceProvider: CollectionsViewDataSourceProvider<PhotoCollection>? {
    didSet {
      collectionsViewDataSourceProvider?.prefetchCollections = { [weak self] in
        self?.fetchCollections()
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Fetches the very first page
    fetchCollections()
  }
  
  /// Handles the fetching of the collection
  /// The page number is automatically updated on each fetch
  fileprivate func fetchCollections() {
    fetchCollections(byPageNumber: currentPage)
  }
  
  fileprivate func configureDataSourceProvider() {
    collectionsViewDataSourceProvider = CollectionsViewDataSourceProvider(models: photoCollections)
    tableView.delegate = collectionsViewDataSourceProvider
    tableView.dataSource = collectionsViewDataSourceProvider
    tableView.prefetchDataSource = collectionsViewDataSourceProvider
  }
  
  fileprivate func configureIsWaitingForConnectivity() {
//    collectionsRepoType?.isWaitingForConnectivityHandler = { [weak self] (session, task) in
//      print("waitin for connectivity")
//    }
  }
}


/// MARK: Fetching implementation

fileprivate extension CollectionsViewController {
  
  /// Loads the photo collections asynchronously with the specified page number
  func fetchCollections(byPageNumber: Int) {
    
    // We won't allow another fetch when this is still in progress
    guard !isFetchInProgress else {
      return
    }
    
    isFetchInProgress = true
    
    collectionsRepoType?.collections(byPageNumber: byPageNumber, curated: false, completion: { [weak self] (result) in
      switch result {
      case let .success(photoCollections):
        self?.isFetchInProgress = false

        self?.photoCollections.append(contentsOf: photoCollections)
        self?.currentPage += 1
        
        DispatchQueue.main.async {
          // Load it the first time
          if self?.collectionsViewDataSourceProvider == nil {
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

