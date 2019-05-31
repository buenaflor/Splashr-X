//
//  PhotoDetailsViewController.swift
//  Splashr-X
//
//  Created by Gino on 30.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

class PhotoDetailsViewController: UIViewController {
  
  var photo: UIImage?
  var details: PhotoTableViewItem?
  
  @IBOutlet weak var photoImageView: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()

    configureViewController()
    configurePhotoImageView()
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
      self.navigationController?.popViewController(animated: true)
    }
  }
  
  fileprivate func setNavigationBarAppearance() {
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.isTranslucent = true
    navigationController?.navigationBar.tintColor = .white
  }
  
  fileprivate func configureViewController() {
    view.backgroundColor = .black
    setNavigationBarAppearance()
  }
  
  fileprivate func configurePhotoImageView() {
    photoImageView.image = photo
  }
}
