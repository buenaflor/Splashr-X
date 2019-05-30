//
//  PhotosViewTableViewCell.swift
//  Splashr-X
//
//  Created by Gino on 29.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

class PhotosViewTableViewCell: UITableViewCell {
  
  // Currently not used
  @IBOutlet weak var colorView: UIView! {
    didSet {
      colorView
        .apply(.circle)
        .apply(.bordered)
    }
  }
  
  @IBOutlet weak var userImageView: UIImageView! {
    didSet {
      userImageView
        .apply(.bordered)
        .apply(.circle)
        .apply(.fill)
    }
  }
  
  @IBOutlet weak var locationLabel: UILabel!
  
  @IBOutlet weak var descriptionLabel: UILabel! {
    didSet {
      descriptionLabel.numberOfLines = 0
      descriptionLabel.sizeToFit()
    }
  }
  
  @IBOutlet weak var likesLabel: UILabel!
  
  @IBOutlet weak var usernameLabel: UILabel!
  
  @IBOutlet weak var createdAtLabel: UILabel!
  
  @IBOutlet weak var photoImageView: UIImageView! {
    didSet {
      photoImageView.apply(.fill)
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    selectionStyle = .none
  }
  
  // MARK: - Action Handlers
  
  var likeButtonTappedHandler: ((UIButton) -> Void)?
  
  @IBAction func likeButtonTapped(_ sender: UIButton) {
    likeButtonTappedHandler?(sender)
  }
  
  var sendButtonTappedHandler: ((UIButton) -> Void)?
  
  @IBAction func sendButtonTapped(_ sender: UIButton) {
    sendButtonTappedHandler?(sender)
  }
  
  var downloadButtonTappedHandler: ((UIButton) -> Void)?

  @IBAction func downloadButtonTapped(_ sender: UIButton) {
    downloadButtonTappedHandler?(sender)
  }
  
  var bookmarkButtonTappedHandler: ((UIButton) -> Void)?

  @IBAction func bookmarkButtonTapped(_ sender: UIButton) {
    bookmarkButtonTappedHandler?(sender)
  }
}


