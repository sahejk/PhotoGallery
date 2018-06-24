//
//  PhotoListLayout.swift
//  PhotoGallery
//
//  Created by Sahej Kaur on 23/06/18.
//  Copyright © 2018 Sahej. All rights reserved.
//

import UIKit

extension PhotoListViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    let paddingDistance = 10 * CGFloat(noOfCellsPerRow - 1)
    let cellWidth = floor(((collectionView.bounds.size.width - paddingDistance) / CGFloat(noOfCellsPerRow)))
    return CGSize(width: cellWidth, height: cellWidth)
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 10
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
    return (self.interactor?.hasNextSlice() ?? false) ? CGSize(width: collectionView.bounds.width, height: 60) : CGSize.zero

  }
}
