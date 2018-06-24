//
//  PhotoListRouter.swift
//  PhotoGallery
//
//  Created by Sahej Kaur on 24/06/18.
//  Copyright © 2018 Sahej. All rights reserved.
//

import UIKit
protocol PhotoListRouterInterface {
  func navigateToPhotoDetails()
}
class PhotoListRouter: PhotoListRouterInterface {
  weak var viewController: PhotoListViewController?
  func navigateToPhotoDetails() {
    viewController?.performSegue(withIdentifier: "showPhotoDetail", sender: nil)
  }
}

extension PhotoListViewController {
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showPhotoDetail", let vc = segue.destination as? PhotoDetailViewController {
      vc.imageThumbnail = self.selectedImage
      vc.photo = self.interactor?.getSelectedPhoto()
    }
  }
}


extension PhotoListViewController: UINavigationControllerDelegate {
  func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
          guard let selectedIndex = self.collectionView.indexPathsForSelectedItems?.first, let cell = self.collectionView.cellForItem(at: selectedIndex) else { return nil}

    switch operation {
    case .push:
      let animator = PresentAnimator(isPresenting: true, originFrame: cell.frame)
      return animator
    default:
      let animator = PresentAnimator(isPresenting: false, originFrame: cell.frame)
      return animator
    }
  }
}
