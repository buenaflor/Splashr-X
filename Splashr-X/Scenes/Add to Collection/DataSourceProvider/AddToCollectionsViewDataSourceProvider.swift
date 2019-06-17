//
//  AddToCollectionsDataSourceProvider.swift
//  Splashr-X
//
//  Created by Gino on 17.06.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

protocol AddToCollectionsViewDataSourceProviderType: CollectionViewDataSourceProvider, Reloadable { }

class AddToCollectionsViewDataSourceProvider<Model: AddToCollectionViewItem>: NSObject, AddToCollectionsViewDataSourceProviderType {
  
  private var models: [Model]
  
  required init(models: [Model]) {
    self.models = models
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    return UICollectionViewCell()
  }
  
  func reloadAll(_ models: [Model]) {
    
  }
  
  func append(_ model: Model) {
    
  }
}

