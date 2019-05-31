//
//  LoginImagePreviewCollectionViewCell.swift
//  Splashr-X
//
//  Created by Gino on 31.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

class LoginImagePreviewCollectionViewCell: UICollectionViewCell {
  
  let photoImageView = UIImageView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    photoImageView.frame = frame
    photoImageView.apply(.fill)
    addSubview(photoImageView)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
