//
//  PhotoListViewController.swift
//  PhotoGallery
//
//  Created by Sahej Kaur on 23/06/18.
//  Copyright © 2018 Sahej. All rights reserved.
//
import UIKit

protocol PhotoListViewControllerInterface: class {
}

class PhotoListViewController: UIViewController, PhotoListViewControllerInterface, UISearchBarDelegate {
  @IBOutlet weak var searchBar: UISearchBar!
  var interactor: PhotoListInteractorInterface?
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    searchBar.delegate = self
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    guard let searchText = searchBar.text else { return }
    let request = PhotoListModels.PhotoSearch.Request(searchText: searchText)
    interactor?.searchPhotos(request: request)
  }
  
}

