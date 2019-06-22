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
  
  private let darkView = UIView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    let screenFrame = CGRect(x: 0.0, y: 0.0, width: frame.width, height: frame.height)
    photoImageView.frame = screenFrame
    darkView.frame = screenFrame
    
    photoImageView.apply(.fill)
    addSubview(photoImageView)
    
    darkView.apply(.darkTransparentBackground)
    addSubview(darkView)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
