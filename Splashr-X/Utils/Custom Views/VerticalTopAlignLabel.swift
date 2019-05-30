//
//  VerticalTopAlignLabel.swift
//  Splashr-X
//
//  Created by Gino on 30.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

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
