//
//  Scene+Instantiate.swift
//  Splashr-X
//
//  Created by Gino on 27.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import Foundation

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

extension TabbarController {
  static func instantiate(dependencies: CoreDependencies) -> TabbarController {
    let tabbarController = TabbarController()
    tabbarController.dependencies = dependencies
    return tabbarController
  }
}
