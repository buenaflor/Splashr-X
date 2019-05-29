//
//  CollectionsViewCellConfigurator.swift
//  Splashr-X
//
//  Created by Gino on 28.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import UIKit
import Nuke

struct CollectionsViewCellConfigurator<Model: PhotoCollectionTableViewItem>: CellConfigurator {

  var model: Model?
  
  func create(from tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
    guard let model = model else {
      return UITableViewCell()
    }
    
    let cell = tableView.dequeue(CollectionsViewTableViewCell.self, for: indexPath)
        
    if let url = URL(string: model.coverPhoto?.urls?.regular ?? "") {
      Nuke.loadImage(with: url, into: cell.coverImageView)
    }
    
    return cell
  }
}
