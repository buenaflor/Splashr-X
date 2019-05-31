//
//  CollectionViewDataSourceProvider.swift
//  Splashr-X
//
//  Created by Gino on 31.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

protocol CollectionViewDataSourceProvider: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout { }

protocol CollectionViewPrefetchable: UICollectionViewDataSourcePrefetching { }
