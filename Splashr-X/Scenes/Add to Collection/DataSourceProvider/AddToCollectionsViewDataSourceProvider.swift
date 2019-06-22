//
//  AddToCollectionsDataSourceProvider.swift
//  Splashr-X
//
//  Created by Gino on 17.06.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import UIKit
import Nuke

protocol AddToCollectionsViewDataSourceProviderType: CollectionViewDataSourceProvider, Reloadable { }

class AddToCollectionsViewDataSourceProvider<Model: AddToCollectionViewItem>: NSObject, AddToCollectionsViewDataSourceProviderType {
  
  private var models: [Model]
  
  required init(models: [Model]) {
    self.models = models
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return models.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    // No cell configurator here because this is a trivial task
    let cell = collectionView.dequeue(AddToCollectionsPhotoCollectionCell.self, for: indexPath)
    let model = models[indexPath.row]
    if let url = URL(string: model.coverPhoto?.urls?.regular ?? "") {
      Nuke.loadImage(with: url, into: cell.coverImageView)
    }
    return cell
  }
  
  typealias SelectedItems = [IndexPath]
  private var selectedItems: SelectedItems = []
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let cell = collectionView.cellForItem(at: indexPath) as? AddToCollectionsPhotoCollectionCell else {
      return
    }
    if !selectedItems.contains(indexPath) {
      selectedItems.append(indexPath)
      cell.addLightLayerOverImage()
    } else {
      selectedItems.removeAll(where: { $0 == indexPath })
      cell.removeLightLayerOverImage()
    }
  }
  
  func reloadAll(_ models: [Model]) {
    self.models = models
  }
  
  func append(_ model: Model) {
    self.models.append(model)
  }
}

