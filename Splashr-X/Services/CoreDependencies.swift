//
//  AppDependencies.swift
//  Splashr-X
//
//  Created by Gino on 30.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import Foundation

protocol HasPhotosRepo {
  var photosRepoType: PhotosRepoType { get }
}

protocol HasCollectionsRepo {
  var collectionsRepoType: CollectionsRepoType { get }
}

final class CoreDependencies: HasPhotosRepo, HasCollectionsRepo {
  var photosRepoType: PhotosRepoType = PhotosRepo()
  var collectionsRepoType: CollectionsRepoType = CollectionsRepo()
}
