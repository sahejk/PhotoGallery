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
    return self.photos.count
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    return collectionView.dequeueReusableCustomCellWithIdentifier("photoCell", forIndexPath: indexPath)
  }
  
  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    if (indexPath.row) == photos.count - 1, let interator =  interactor, interator.hasNextSlice() {
      interactor?.fetchNextSlice()
    }
  }

  
}
