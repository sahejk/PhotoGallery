//
//  PhotoListViewController.swift
//  PhotoGallery
//
//  Created by Sahej Kaur on 23/06/18.
//  Copyright © 2018 Sahej. All rights reserved.
//
import UIKit

protocol PhotoListViewControllerInterface: class {
  func presentSearchResults(photoURLs: [URL])
}

protocol LayoutMenuDelegate: class {
  func selectedLayout(noOfCells: Int)
}

class PhotoListViewController:UIViewController, PhotoListViewControllerInterface, UISearchBarDelegate, UIPopoverPresentationControllerDelegate, LayoutMenuDelegate {
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var collectionView: UICollectionView!
  var interactor: PhotoListInteractorInterface?
  var router: PhotoListRouterInterface?

  var photoURLs: [URL] = [] {
    didSet {
      updateCollectionView()
    }
  }
  var selectedImage: UIImage?
  var noOfCellsPerRow = 2 {
    didSet {
      collectionView.reloadData()
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    PhotoListConfigurator.sharedInstance.configure(viewController: self)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    searchBar.delegate = self
    collectionView.dataSource = self
    collectionView.delegate = self
    self.navigationController?.delegate = self
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    guard let searchText = searchBar.text else { return }
    let request = PhotoListModels.PhotoSearch.Request(searchText: searchText)
    interactor?.searchPhotos(request: request)
  }
  
  func presentSearchResults(photoURLs: [URL]) {
    self.photoURLs = photoURLs
  }
  
  func updateCollectionView() {
    collectionView.reloadData()
  }
  
  func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle
  {
    return .none
  }
  
  func selectedLayout(noOfCells: Int) {
    self.noOfCellsPerRow = noOfCells
    self.dismiss(animated: true, completion: nil)
  }

}



extension PhotoListViewController {
  @IBAction func layoutMenuTapped(_ sender: UIButton) {
    if let popController = UIStoryboard(name: "PhotoList", bundle: nil).instantiateViewController(withIdentifier: "layoutMenu") as? PhotoLayoutMenuViewController {
      popController.menuSelectionDelegate = self
    popController.preferredContentSize = CGSize(width: 132, height: 132)
    popController.modalPresentationStyle = UIModalPresentationStyle.popover
    popController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.up
    popController.popoverPresentationController?.delegate = self
    popController.popoverPresentationController?.sourceView = sender // button
    popController.popoverPresentationController?.sourceRect = sender.bounds
    self.present(popController, animated: true, completion: nil)
    }
  }
}

