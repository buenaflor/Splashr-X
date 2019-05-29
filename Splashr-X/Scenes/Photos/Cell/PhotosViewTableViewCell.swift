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
}

class VerticalTopAlignLabel: UILabel {
  
  override func drawText(in rect:CGRect) {
    guard let labelText = text else {  return super.drawText(in: rect) }
    
    let attributedText = NSAttributedString(string: labelText, attributes: [NSAttributedString.Key.font: font ?? UIFont.systemFont(ofSize: 12)])
    var newRect = rect
    newRect.size.height = attributedText.boundingRect(with: rect.size, options: .usesLineFragmentOrigin, context: nil).size.height
    
    if numberOfLines != 0 {
      newRect.size.height = min(newRect.size.height, CGFloat(numberOfLines) * font.lineHeight)
    }
    
    super.drawText(in: newRect)
  }
  
}
