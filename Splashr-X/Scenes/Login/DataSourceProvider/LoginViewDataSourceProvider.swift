//
//  LoginViewDataSourceProvider.swift
//  Splashr-X
//
//  Created by Gino on 31.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

class LoginViewDataSourceProvider<Model: UIImage>: NSObject, CollectionViewDataSourceProvider {
  
  private let models: [Model]
  
  required init(models: [Model]) {
    self.models = models
  }
  
  // MARK: - DataSource
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return models.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeue(LoginImagePreviewCollectionViewCell.self, for: indexPath)
    let photo = models[indexPath.row]
    
    cell.photoImageView.image = photo
    
    return cell
  }
  
}
