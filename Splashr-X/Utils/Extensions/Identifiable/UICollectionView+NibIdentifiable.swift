//
//  UICollectionView+NibIdentifiable.swift
//  Splashr
//
//  Created by Giancarlo Buenaflor on 02.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

extension UICollectionView {
  
  func register<C: UICollectionViewCell>(cellType: C.Type) where C: ClassIdentifiable {
    register(cellType.self, forCellWithReuseIdentifier: cellType.reuseId)
  }
  
  func register<C: UICollectionViewCell>(cellType: C.Type) where C: NibIdentifiable & ClassIdentifiable {
    register(cellType.nib, forCellWithReuseIdentifier: cellType.reuseId)
  }
  
  func register<C: UICollectionViewCell>(cellType: C.Type, forSupplementaryViewOfKind kind: String) where C: NibIdentifiable & ClassIdentifiable {
    register(cellType.nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: cellType.reuseId)
  }
  
  func dequeueReusableCell<C: UICollectionViewCell>(withCellType type: C.Type = C.self, forIndexPath indexPath: IndexPath) -> C where C: ClassIdentifiable {
    guard let cell = dequeueReusableCell(withReuseIdentifier: type.reuseId, for: indexPath) as? C
      else { fatalError("Couldn't dequeue a UICollectionViewCell with identifier: \(type.reuseId)") }
    return cell
  }

  func dequeueReusableSupplementaryView<C: UICollectionReusableView>(of kind: String, withCellType type: C.Type = C.self, forIndexPath indexPath: IndexPath) -> C where C: ClassIdentifiable {
    guard let cell = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: type.reuseId, for: indexPath) as? C else {
       fatalError("Couldn't dequeue a UICollectionViewCell with identifier: \(type.reuseId)")
    }
    return cell
  }
}
