//
//  ImageZoomScrollView.swift
//  Splashr-X
//
//  Created by Gino on 31.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

class ImageZoomScrollView: UIScrollView, UIScrollViewDelegate {
  
  var imageView = UIImageView()
  
  func configure(topBarHeight: CGFloat) {
    if let width = imageView.image?.size.width,
      let height = imageView.image?.size.height {
      let ratio = width / height
      let newHeight = frame.width / ratio
      imageView.frame = CGRect(x: 0.0, y: 0.0, width: frame.width, height: newHeight)
      imageView.center = scrollViewCenter
      imageView.center.y -= topBarHeight
      contentSize = CGSize(width: frame.width, height: newHeight)
    }
    
    imageView.apply(.fill)
    addSubview(imageView)
    
    setupScrollView()
    setupGestureRecognizer()
  }
  
  // Sets the scroll view delegate and zoom scale limits.
  // Change the `maximumZoomScale` to allow zooming more than 2x.
  private func setupScrollView() {
    delegate = self
    minimumZoomScale = 1.0
    maximumZoomScale = 6.0
    alwaysBounceVertical = false
    alwaysBounceHorizontal = false
    showsVerticalScrollIndicator = true
    flashScrollIndicators()
  }
  
  private func setupGestureRecognizer() {
    let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(doubleTappedImageView(_:)))
    doubleTapGesture.numberOfTapsRequired = 2
    addGestureRecognizer(doubleTapGesture)
  }
  
  @objc private func doubleTappedImageView(_ sender: UITapGestureRecognizer) {
    if zoomScale == 1 {
      zoom(to: zoomRectForScale(maximumZoomScale, center: sender.location(in: sender.view)), animated: true)
    } else {
      setZoomScale(1, animated: true)
    }
  }
  
  // Tell the scroll view delegate which view to use for zooming and scrolling
  func viewForZooming(in scrollView: UIScrollView) -> UIView? {
    return imageView
  }
  
  // Calculates the zoom rectangle for the scale
  private func zoomRectForScale(_ scale: CGFloat, center: CGPoint) -> CGRect {
    var zoomRect = CGRect.zero
    zoomRect.size.height = imageView.frame.size.height / scale
    zoomRect.size.width = imageView.frame.size.width / scale
    let newCenter = convert(center, from: imageView)
    zoomRect.origin.x = newCenter.x - (zoomRect.size.width / 2.0)
    zoomRect.origin.y = newCenter.y - (zoomRect.size.height / 2.0)
    return zoomRect
  }
  
  var scrollViewCenter: CGPoint {
    let scrollViewSize: CGSize = visibleSize
    return CGPoint(x: scrollViewSize.width / 2.0, y: (scrollViewSize.height / 2.0))
  }
}
