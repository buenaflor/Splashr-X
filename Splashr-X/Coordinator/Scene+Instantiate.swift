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
  static func instantiate(photoRepoType: PhotoRepoType) -> PhotosViewController {
    let vc = PhotosViewController.initFromNib()
    vc.photoRepoType = photoRepoType
    return vc
  }
}
