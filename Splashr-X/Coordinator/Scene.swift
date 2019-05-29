//
//  Scene.swift
//  Splashr
//
//  Created by Giancarlo Buenaflor on 02.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

protocol TargetScene {
  var transition: SceneTransitionType { get }
}

enum Scene {
  /// The list of collections scene
  case collection
  
  /// The list of photos screen
  case photos
}

extension Scene: TargetScene {
  var transition: SceneTransitionType {
    switch self {
    case .collection:
      let collectionsRepoType: CollectionsRepoType = CollectionsRepo()
      let collectionsVC = CollectionsViewController.instantiate(collectionsRepoType: collectionsRepoType)
      return .root(collectionsVC)
    case .photos:
      let photoRepoType: PhotoRepoType = PhotoRepo()
      let photosVC = PhotosViewController.instantiate(photoRepoType: photoRepoType)
      return .root(photosVC)
    }
  }
}

