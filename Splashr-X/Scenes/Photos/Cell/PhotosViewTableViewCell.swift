//
//  PhotosViewTableViewCell.swift
//  Splashr-X
//
//  Created by Gino on 29.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

class PhotosViewTableViewCell: UITableViewCell {
  @IBOutlet weak var colorView: UIView! {
    didSet {
      colorView
        .apply(.circle)
        .apply(.bordered)
    }
  }
  
  @IBOutlet weak var locationLabel: UILabel!
  
  @IBOutlet weak var userImageView: UIImageView! {
    didSet {
      userImageView
        .apply(.bordered)
        .apply(.circle)
        .apply(.fill)
    }
  }
  
  @IBOutlet weak var usernameLabel: UILabel!
  
  @IBOutlet weak var photoImageView: UIImageView! {
    didSet {
      photoImageView.apply(.fill)
    }
  }
  
}

