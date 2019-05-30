//
//  TabbarController.swift
//  Splashr-X
//
//  Created by Gino on 30.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

class TabbarController: UITabBarController {
  
  typealias Dependencies = HasPhotosRepo & HasCollectionsRepo
  var dependencies: Dependencies? {
    didSet {
      loadViewControllers()
    }
  }
  
  /// Loads the dependencies and injects them to the VCs
  /// VCs are then added to the Tabbar
  func loadViewControllers() {
    guard let photosRepoType = dependencies?.photosRepoType,
          let collectionsRepoType = dependencies?.collectionsRepoType else {
      print("error creating dependencies, couldn't load tabbar")
      return
    }
    let photosVC = PhotosViewController.instantiate(photosRepoType: photosRepoType)
    let photosTabbarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "heart_outlined"), selectedImage: #imageLiteral(resourceName: "heart_filled"))
    photosVC.tabBarItem = photosTabbarItem

    let collectionsVC = CollectionsViewController.instantiate(collectionsRepoType: collectionsRepoType)
    let collectionsTabbarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "bookmark_outlined"), selectedImage: #imageLiteral(resourceName: "bookmark_filled"))
    collectionsVC.tabBarItem = collectionsTabbarItem
    
    viewControllers = [photosVC, collectionsVC]
  }
}
