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
  
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  @IBOutlet weak var userImageView: UIImageView! {
    didSet {
      userImageView
        .apply(.bordered)
        .apply(.circle)
        .apply(.fill)
    }
  }
  
  @IBOutlet weak var photoImageView: UIImageView! {
    didSet {
      photoImageView.apply(.fill)
      let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(photoImageViewTapped(_:)))
      addGestureRecognizer(tapGestureRecognizer)
    }
  }
  
  var photoImageViewTappedHandler: ((UIImageView) -> Void)?

  @objc private func photoImageViewTapped(_ sender: UITapGestureRecognizer) {
    photoImageViewTappedHandler?(photoImageView)
  }
  
  @IBOutlet weak var locationLabel: UILabel!
  
  @IBOutlet weak var descriptionLabel: UILabel!
  
  @IBOutlet weak var likesLabel: UILabel!
  
  @IBOutlet weak var usernameLabel: UILabel!
  
  @IBOutlet weak var createdAtLabel: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()
    selectionStyle = .none
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
  }
  
  // MARK: - Action Handlers
  
  var likeButtonTappedHandler: ((UIButton) -> Void)?
  
  @IBAction private func likeButtonTapped(_ sender: UIButton) {
    likeButtonTappedHandler?(sender)
  }
  
  var sendButtonTappedHandler: ((UIButton, UIImage) -> Void)?
  
  @IBAction private func sendButtonTapped(_ sender: UIButton) {
    guard let photo = photoImageView.image else {
      print("error, no image??")
      return
    }
    sendButtonTappedHandler?(sender, photo)
  }

  var downloadButtonTappedHandler: ((UIButton, UIImage) -> Void)?

  @IBAction private func downloadButtonTapped(_ sender: UIButton) {
    guard let photo = photoImageView.image else {
      print("error, no image??")
      return
    }
    downloadButtonTappedHandler?(sender, photo)
  }
  
  var bookmarkButtonTappedHandler: ((UIButton) -> Void)?

  @IBAction private func bookmarkButtonTapped(_ sender: UIButton) {
    bookmarkButtonTappedHandler?(sender)
  }
}


