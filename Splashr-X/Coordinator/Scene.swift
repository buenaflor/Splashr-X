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
  case collection
//  case searchCollectionsPhotos(SearchCollectionsPhotoable, UIImage?)
//  case photoDetails(Photo?, UIImage?)
//  case photoPreview(Photo?, UIImage?, UILongPressGestureRecognizer)
}

extension Scene: TargetScene {
  var transition: SceneTransitionType {
    switch self {
    case .collection:
      let collectionsVC = ViewController()
      return .root(collectionsVC)
//    case let .searchCollectionsPhotos(photoCollection, coverImage):
//      let searchCollectionsPhotosVC = SearchCollectionsPhotosViewController.instantiate(photoCollection: photoCollection,
//                                                                                        coverImage: coverImage)
//      let navController = searchCollectionsPhotosVC.wrapped()
//      return .present(navController)
//    case let .photoDetails(photo, image):
//      let photoDetailsVC = PhotoDetailsViewController.instantiate(photo: photo, image: image)
//      return .present(photoDetailsVC)
//    case let .photoPreview(photo, image, gestureRecognizer):
//      let photoPreviewVC = PhotoPreviewViewController.instantiate(photo: photo, image: image, gestureRecognizer: gestureRecognizer)
//      return .present(photoPreviewVC)
    }
  }
}

//fileprivate extension SearchCollectionsPhotosViewController {
//  static func instantiate(photoCollection: SearchCollectionsPhotoable, coverImage: UIImage?) -> SearchCollectionsPhotosViewController  {
//    let searchCollectionsPhotosVC = SearchCollectionsPhotosViewController.initFromNib()
//    searchCollectionsPhotosVC.initializeEssentials(photoCollection: photoCollection,
//                                                   coverImage: coverImage)
//    searchCollectionsPhotosVC.searchCollectionsRepositoryType = SearchCollectionsRepository()
//    return searchCollectionsPhotosVC
//  }
//
//  func wrapped() -> UINavigationController {
//    let navController = UINavigationController(rootViewController: self)
//    navController.hero.isEnabled = true
//    return navController
//  }
//}
//
//fileprivate extension CollectionsViewController {
//  static func instantiate() -> CollectionsViewController {
//    let repository = CollectionsRepository()
//    let collectionsVC = CollectionsViewController(repository: repository)
//    return collectionsVC
//  }
//}
//
//fileprivate extension PhotoDetailsViewController {
//  static func instantiate(photo: Photo?, image: UIImage?) -> PhotoDetailsViewController {
//    let photoDetailsVC = PhotoDetailsViewController.initFromNib()
//    photoDetailsVC.image = image
//    photoDetailsVC.photo = photo
//    return photoDetailsVC
//  }
//}
//
//fileprivate extension PhotoPreviewViewController {
//  static func instantiate(photo: Photo?, image: UIImage?, gestureRecognizer: UILongPressGestureRecognizer) -> PhotoPreviewViewController {
//    let photoPreviewVC = PhotoPreviewViewController.initFromNib()
//    photoPreviewVC.image = image
//    photoPreviewVC.photo = photo
//    photoPreviewVC.gestureRecognizer = gestureRecognizer
//    return photoPreviewVC
//  }
//}
