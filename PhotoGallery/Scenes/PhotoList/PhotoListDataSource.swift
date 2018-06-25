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
    cell.imageView.associatedDownloadTask = ImageDownloadManager.shared.downloadImage(requestURL: photoURLs[indexPath.row], completion: { (image, url) in
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
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    self.selectedImage = (collectionView.cellForItem(at: indexPath) as? PhotoCell)?.imageView.image
    interactor?.selectedIndex = indexPath.row
    
    let attributes = collectionView.layoutAttributesForItem(at: indexPath)
    let attributesFrame = attributes?.frame
    let frameToOpenFrom = collectionView.convert(attributesFrame!, to: collectionView.superview)
    self.openingFrame = frameToOpenFrom
    router?.navigateToPhotoDetails()
  }
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {    
    switch kind {
    case UICollectionElementKindSectionFooter:
      let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "footer", for: indexPath as IndexPath)
      let spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
      spinner.startAnimating()
      spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: collectionView.bounds.width, height: 60)
      footerView.addSubview(spinner)
      return footerView
    default:
      assert(false, "Unexpected element kind")
    }
  }
}
