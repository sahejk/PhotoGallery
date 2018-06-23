//
//  ImageStore.swift
//  PhotoGallery
//
//  Created by Sahej Kaur on 24/06/18.
//  Copyright © 2018 Sahej. All rights reserved.
//

import Foundation

protocol ImageStore {
  func fetchImage(request: PhotoListModels.ImageFetch.Request)
}

class ImageRestStore: ImageStore {
  func fetchImage(request: PhotoListModels.ImageFetch.Request) {
    
  }
}
