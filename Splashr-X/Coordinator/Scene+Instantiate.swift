//
//  Scene+Instantiate.swift
//  Splashr-X
//
//  Created by Gino on 27.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

extension CollectionsViewController {
  static func instantiate(collectionsRepoType: CollectionsRepoType) -> CollectionsViewController {
    let vc = CollectionsViewController.initFromNib()
    vc.collectionsRepoType = collectionsRepoType
    return vc
  }
}

extension PhotosViewController {
  static func instantiate(photosRepoType: PhotosRepoType) -> PhotosViewController {
    let vc = PhotosViewController.initFromNib()
    vc.photosRepoType = photosRepoType
    return vc
  }
}

extension TabBarController {
  static func instantiate(dependencies: CoreDependencies) -> TabBarController {
    let tabbarController = TabBarController()
    tabbarController.dependencies = dependencies
    return tabbarController
  }
}

extension PhotoDetailsViewController {
  static func instantiate(photo: UIImage, details: PhotoTableViewItem) -> PhotoDetailsViewController {
    let photoDetailsVC = PhotoDetailsViewController()
    photoDetailsVC.photo = photo
    photoDetailsVC.details = details
    return photoDetailsVC
  }
}

extension LoginViewController {
  static func instantiate(dismissAnimatable: DismissAnimatable) -> LoginViewController {
    let loginVC = LoginViewController()
    loginVC.dismissAnimatable = dismissAnimatable
    return loginVC
  }
}
