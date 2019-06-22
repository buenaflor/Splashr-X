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
  
  let lightView = UIView()
  
  func addLightLayerOverImage() {
    lightView.frame = coverImageView.frame
    lightView.backgroundColor = UIColor.white.withAlphaComponent(0.3)
    coverImageView.addSubview(lightView)
  }
  
  func removeLightLayerOverImage() {
    lightView.removeFromSuperview()
  }
}
