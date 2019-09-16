//
//  MapViewController+SearchBarDelegate.swift
//  StarLinkApplication
//
//  Created by Administrator on 18/03/19.
//  Copyright © 2019 Sreelekh. All rights reserved.
//

import Foundation
import GooglePlaces

// MARK: - SEARCHBAR DELEGATE
extension DVT_MapViewController : UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        let filter = GMSAutocompleteFilter()
        filter.type = .establishment  //suitable filter type
        filter.country = "SA"  //appropriate country code
        autocompleteController.autocompleteFilter = filter
        present(autocompleteController, animated: true, completion: nil)
    }
}
