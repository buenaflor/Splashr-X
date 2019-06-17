//
//  PhotosDataSourceProvider.swift
//  Splashr-X
//
//  Created by Gino on 29.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

class PhotosViewDataSourceProvider<Model: PhotoTableViewItem>: NSObject, TableViewDataSourceProvider, TableViewPrefetchable, Reloadable {

  private var cellConfigurator: PhotosViewCellConfigurator<Model>?
  private var models: [Model]
  
  required init(models: [Model]) {
    self.models = models
    self.cellConfigurator = PhotosViewCellConfigurator()
  }
  
  // MARK: - DataSource

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return models.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // Create loading cell if photoCollections == indexPath.row
    guard indexPath.row < models.count else {
      return tableView.dequeue(UITableViewCell.self, for: indexPath)
    }
    let model = models[indexPath.row]
    cellConfigurator?.model = model
    guard let cell = cellConfigurator?.create(from: tableView, at: indexPath) else {
      return UITableViewCell()
    }
    
    if let cell = cell as? PhotosViewTableViewCell {
      cell.likeButtonTappedHandler = { [weak self] button in
        self?.likeButtonTappedHandler?(button, model)
      }
      cell.sendButtonTappedHandler = { [weak self] button, photo in
        self?.sendButtonTappedHandler?(button, photo)
      }
      cell.downloadButtonTappedHandler = { [weak self] button, photo in
        self?.downloadButtonTappedHandler?(button, photo)
      }
      cell.bookmarkButtonTappedHandler = { [weak self] button, photo in
        self?.bookmarkButtonTappedHandler?(button, model, photo)
      }
      cell.photoImageViewTappedHandler = { [weak self] imageView in
        self?.photoImageViewTappedHandler?(imageView, model, cell)
      }
    }
    
    return cell
  }
  
  var likeButtonTappedHandler: ((UIButton, PhotoTableViewItem) -> Void)?
  var sendButtonTappedHandler: ((UIButton, UIImage) -> Void)?
  var downloadButtonTappedHandler: ((UIButton, UIImage) -> Void)?
  var bookmarkButtonTappedHandler: ((UIButton, PhotoTableViewItem, UIImage) -> Void)?
  var photoImageViewTappedHandler: ((UIImageView, PhotoTableViewItem, UITableViewCell) -> Void)?

  // MARK: - Prefetching
  
  var prefetchCollections: (() -> Void)?
  
  func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
    if indexPaths.contains(where: { tableView.isLoadingCell(for: $0, modelCount: models.count - 1) }) {
      prefetchCollections?()
    }
  }
  
  // MARK: - Delegate

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.row == models.count - 1 {
      return 0
    }
    
    let model = models[indexPath.row]
    guard let width = model.width,
          let height = model.height else {
        return 500
    }
    let ratio = CGFloat(width) / CGFloat(height)
    let newHeight = tableView.frame.width / ratio
    
    // This is the padding that is additionally added with the stack views
    let stackViewPaddings: CGFloat = 120
    
    return newHeight + stackViewPaddings
  }
}

// MARK: - Reloadable

extension PhotosViewDataSourceProvider {
  func reloadAll(_ models: [Model]) {
    self.models = models
  }
  
  
  func append(_ model: Model) {
    self.models.append(model)
  }
}
