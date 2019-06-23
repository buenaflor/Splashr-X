//
//  AddToCollectionsPhotoCollectionCell.swift
//  Splashr-X
//
//  Created by Gino on 22.06.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

class AddToCollectionsPhotoCollectionCell: UICollectionViewCell {
  
  @IBOutlet weak var coverImageView: UIImageView! {
    didSet {
      coverImageView
        .apply(.fill)
        .apply(.rounded)
    }
  }
  @IBOutlet weak var checkmarkImageView: UIImageView! {
    didSet {
      checkmarkImageView.isHidden = true
    }
  }
  
  @IBOutlet weak var collectionTitleLabel: UILabel!
  
  @IBOutlet weak var lightView: UIView! {
    didSet {
      lightView.isHidden = true
      lightView.backgroundColor = UIColor.white.withAlphaComponent(0.4)
    }
  }
  
  func addLightLayerOverImage() {
    lightView.isHidden = false
  }
  
  func removeLightLayerOverImage() {
    lightView.isHidden = true
  }
  
  func addCheckmarkView() {
    checkmarkImageView.isHidden = false
  }
  
  func removeCheckmarkView() {
    checkmarkImageView.isHidden = true
  }
}
