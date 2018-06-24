//
//  PhotoListDataSource.swift
//  PhotoGallery
//
//  Created by Sahej Kaur on 23/06/18.
//  Copyright © 2018 Sahej. All rights reserved.
//

import UIKit


extension PhotoListViewController: UICollectionViewDataSource {
  
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.photoURLs.count
  }
  
  
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: PhotoCell = collectionView.dequeueReusableCustomCellWithIdentifier("photoCell", forIndexPath: indexPath)
    cell.imageView.image = UIImage(named: "photo_placeholder")
    cell.imageView.associatedObject?.cancel()
    cell.imageView.associatedObject = ImageDownloadManager.shared.downloadImage(requestURL: photoURLs[indexPath.row], completion: { (image, url) in
      cell.imageView.image = image
    })
    return cell
  }
  
  private func validatePaginationRequired(indexPath: IndexPath) {
    if (indexPath.row) == photoURLs.count - 1, let interator =  interactor, interator.hasNextSlice() {
      interactor?.fetchNextSlice()
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    validatePaginationRequired(indexPath: indexPath)
  }
}
