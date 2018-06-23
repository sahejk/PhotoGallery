//
//  PhotoListViewController.swift
//  PhotoGallery
//
//  Created by Sahej Kaur on 23/06/18.
//  Copyright © 2018 Sahej. All rights reserved.
//
import UIKit

protocol PhotoListViewControllerInterface: class {
  func presentSearchResults(photos: [Photo])
}

class PhotoListViewController:UIViewController, PhotoListViewControllerInterface, UISearchBarDelegate {
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var collectionView: UICollectionView!
  var interactor: PhotoListInteractorInterface?
  
  var photos: [Photo] = [] {
    didSet {
      updateCollectionView()
    }
  }
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
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    guard let searchText = searchBar.text else { return }
    let request = PhotoListModels.PhotoSearch.Request(searchText: searchText)
    interactor?.searchPhotos(request: request)
  }
  
  func presentSearchResults(photos: [Photo]) {
    self.photos = photos
  }
  
  func updateCollectionView() {
    collectionView.reloadData()
  }
  
}

