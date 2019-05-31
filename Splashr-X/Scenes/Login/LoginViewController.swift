//
//  LoginViewController.swift
//  Splashr-X
//
//  Created by Gino on 31.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
  
  fileprivate var loginViewDataSourceProvider: LoginViewDataSourceProvider<UIImage>?
  
  @IBOutlet weak var loginButton: UIButton! {
    didSet {
      loginButton.apply(.cornered)
    }
  }
  
  @IBOutlet weak var collectionView: UICollectionView! {
    didSet {
      collectionView.register(LoginImagePreviewCollectionViewCell.self)
      if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
        layout.itemSize = CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureDataSourceProvider()
  }
  
  /// Configures the data source provider
  fileprivate func configureDataSourceProvider() {
    loginViewDataSourceProvider = LoginViewDataSourceProvider(models: [#imageLiteral(resourceName: "kelli-mcclintock-1638116-unsplash"), #imageLiteral(resourceName: "photo-1559197062-ebdd7f51f714"), #imageLiteral(resourceName: "the-tonik-1637267-unsplash"), #imageLiteral(resourceName: "thomas-q-1636458-unsplash"), #imageLiteral(resourceName: "mae-mu-1637488-unsplash"), #imageLiteral(resourceName: "jc-falcon-1636322-unsplash"), #imageLiteral(resourceName: "karl-bewick-1638162-unsplash")])
    collectionView.delegate = loginViewDataSourceProvider
    collectionView.dataSource = loginViewDataSourceProvider
  }
  
  
  @IBAction private func loginButtonTapped(_ sender: UIButton) {
    
  }
}
