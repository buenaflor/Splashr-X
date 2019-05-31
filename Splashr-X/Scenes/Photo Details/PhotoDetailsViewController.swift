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
  var toFrame: CGRect = .zero {
    didSet {
      imageZoomView.configure(topBarHeight: topbarHeight)
      
    }
  }
  
  @IBOutlet weak var photoImageView: UIImageView!
  
  @IBOutlet weak var imageZoomView: ImageZoomScrollView!
  
  override func viewDidLoad() {
    super.viewDidLoad()

    configureViewController()
    configurePhotoImageView()
  }
  
  fileprivate func setNavigationBarAppearance() {
    let downloadItem = UIBarButtonItem(image: #imageLiteral(resourceName: "arrow_down"), style: .plain, target: self, action: #selector(downloadItemTapped(_:)))
    navigationItem.rightBarButtonItem = downloadItem
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
//    photoImageView.image = photo
    imageZoomView.imageView.image = photo
  }
  
  @objc private func downloadItemTapped(_ sender: UIBarButtonItem) {
    guard let photo = photo else {
      print("error, image is not available?!")
      CustomHUD.showError(title: "Error", details: "Couldn't save photo")
      return
    }
    
    let alert = AlertPresenter.savePhotoToLibray { saveToPhotos in
      if saveToPhotos {
        self.savePhotoToAlbum(photo)
      }
    }
    alert.present(in: self)
  }
  
  fileprivate func savePhotoToAlbum(_ photo: UIImage) {
    PhotoLibraryManager.shared.save(photo)
  }
  
}
