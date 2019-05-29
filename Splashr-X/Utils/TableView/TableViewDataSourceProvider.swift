//
//  TableViewDataSourceProvider.swift
//  Splashr-X
//
//  Created by Gino on 28.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

protocol TableViewDataSourceProvider: UITableViewDataSource, UITableViewDelegate { }

protocol TableViewPrefetchable: UITableViewDataSourcePrefetching { }
