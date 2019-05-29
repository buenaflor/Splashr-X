//
//  CollectionsViewDataSourceProvider.swift
//  Splashr-X
//
//  Created by Gino on 28.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

protocol CollectionsViewDataSourceProviderType: TableViewDataSourceProvider, TableViewPrefetchable, Reloadable { }

class CollectionsViewDataSourceProvider<Model: PhotoCollectionTableViewItem>: NSObject, CollectionsViewDataSourceProviderType {
  
  private var cellConfigurator: CollectionsViewCellConfigurator<Model>?
  private var models: [Model]
  
  required init(models: [Model]) {
    self.models = models
    self.cellConfigurator = CollectionsViewCellConfigurator()
  }
  
  // MARK: - DataSource

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return models.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // Create loading cell if photoCollections == indexPath.row
    guard indexPath.row < models.count else {
      let cell = tableView.dequeue(UITableViewCell.self, for: indexPath)
      cell.textLabel?.text = "loading cell"
      return cell
    }
    cellConfigurator?.model = models[indexPath.row]
    guard let cell = cellConfigurator?.create(from: tableView, at: indexPath) else {
      return UITableViewCell()
    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.row == models.count - 1 {
      return 0
    }
    
    let model = models[indexPath.row]
    guard let width = model.coverPhoto?.width,
          let height = model.coverPhoto?.height else {
      return 500
    }
    let ratio = CGFloat(width) / CGFloat(height)
    let newHeight = tableView.frame.width / ratio
    return newHeight
  }
  
  // MARK: - Prefetching
  
  var prefetchCollections: (() -> Void)?
  
  func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
    if indexPaths.contains(where: { tableView.isLoadingCell(for: $0, modelCount: models.count - 1) }) {
      prefetchCollections?()
    }
  }
  
  // MARK: - Delegate
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
  }
}

// MARK: - Reloadable

extension CollectionsViewDataSourceProvider {
  func reloadAll(_ models: [Model]) {
    self.models = models
  }
  
  
  func append(_ model: Model) {
    self.models.append(model)
  }
  
}
