//
//  UIImageView+AssociatedObject.swift
//  PhotoGallery
//
//  Created by Sahej Kaur on 24/06/18.
//  Copyright © 2018 Sahej. All rights reserved.
//

import UIKit
extension UIImageView {
  private struct AssociatedKeys {
    static var dataTaskAssociatedObject = "nsh_DataTask"
  }
  
  var associatedDownloadTask: URLSessionDataTask? {
    get {
      return objc_getAssociatedObject(self, &AssociatedKeys.dataTaskAssociatedObject) as? URLSessionDataTask
    }
    
    set {
      if let newValue = newValue {
        objc_setAssociatedObject(
          self,
          &AssociatedKeys.dataTaskAssociatedObject,
          newValue as URLSessionDataTask?,
          .OBJC_ASSOCIATION_RETAIN_NONATOMIC
        )
      }
    }
  }
}

