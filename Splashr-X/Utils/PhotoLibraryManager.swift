//
//  PhotoLibraryManager.swift
//  Splashr-X
//
//  Created by Gino on 31.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import UIKit
import PKHUD

/// PhotoLibraryManager is responsible for saving photos to your photo library
class PhotoLibraryManager: NSObject {
  private override init() { }
  
  static let shared = PhotoLibraryManager()
  
  func save(_ photo: UIImage) {
    UIImageWriteToSavedPhotosAlbum(photo, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
  }
  
  @objc private func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
    if let error = error {
      // we got back an error!
      print("error, couln't save?!: ", error)
      CustomHUD.showError(title: "Error", details: "Couldn't save photo")
    } else {
      CustomHUD.showSuccess(title: "Success", details: "Photo has been saved")
    }
  }
}


