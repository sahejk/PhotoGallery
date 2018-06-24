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
    let photoURLs = response.photos.map { (photo) -> URL in
      let urlString = "https://farm\(photo.farm).staticflickr.com/\(photo.server)/\(photo.id)_\(photo.secret)_t.jpg"
      return URL(string: urlString)!
    }
    viewController?.presentSearchResults(photoURLs: photoURLs)
  }

}

//https://farm2.staticflickr.com/1794/29092961018_7878516155_t.jpg

