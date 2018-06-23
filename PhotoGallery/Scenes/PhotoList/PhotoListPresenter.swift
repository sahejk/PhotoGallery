//
//  PhotoListPresenter.swift
//  PhotoGallery
//
//  Created by Sahej Kaur on 23/06/18.
//  Copyright © 2018 Sahej. All rights reserved.
//

import Foundation

protocol PhotoListPresenterInterface {
  func presentPhotoData(response: PhotoListModels.PhotoSearch.Response)
  
}

class PhotoListPresenter: PhotoListPresenterInterface {
  weak var viewController: PhotoListViewControllerInterface?
  
  func presentPhotoData(response: PhotoListModels.PhotoSearch.Response) {
    viewController?.presentSearchResults(photos: response.photos)
  }

}
