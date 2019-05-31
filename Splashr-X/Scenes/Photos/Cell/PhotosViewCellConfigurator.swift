//
//  PhotosViewCellConfigurator.swift
//  Splashr-X
//
//  Created by Gino on 29.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import UIKit
import Nuke

class PhotosViewCellConfigurator<Model: PhotoTableViewItem>: CellConfigurator {
  
  var model: Model?
  
  func create(from tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
    guard let model = model else {
      return tableView.dequeue(UITableViewCell.self, for: indexPath)
    }
    
    let cell = tableView.dequeue(PhotosViewTableViewCell.self, for: indexPath)
    
    if let user = model.user {
      if let url = URL(string: user.profileImage?.medium ?? "") {
        Nuke.loadImage(with: url, into: cell.userImageView)
      }
      if let username = user.fullName {
        cell.usernameLabel.text = username
      }
    }
    if let color = model.color {
      cell.locationLabel.text = "\(color)"
      cell.colorView.isHidden = true
    }
    if let likes = model.likes {
      cell.likesLabel.text = "\(likes) likes"
    }
    if let description = model.description {
      cell.descriptionLabel.text = description
    } else {
      cell.descriptionLabel.isHidden = true
    }
    if let createdAt = model.created {
      cell.createdAtLabel.text = createdAt
    }
    if let url = URL(string: model.urls?.regular ?? "") {
      Nuke.loadImage(with: url, into: cell.photoImageView)
    }
    
    return cell
  }
}
