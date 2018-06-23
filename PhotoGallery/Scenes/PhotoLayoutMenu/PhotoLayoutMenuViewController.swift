//
//  PhotoLayoutMenuViewController.swift
//  PhotoGallery
//
//  Created by Sahej Kaur on 24/06/18.
//  Copyright © 2018 Sahej. All rights reserved.
//

import UIKit
class PhotoLayoutMenuViewController: UITableViewController {
  var layoutOptions = [2,3,4]
  weak var menuSelectionDelegate: LayoutMenuDelegate?
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    menuSelectionDelegate?.selectedLayout(noOfCells: layoutOptions[indexPath.row])
  }
}
