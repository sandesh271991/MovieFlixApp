//
//  TopRatedMovie+SearchBar.swift
//  MovieFlixApp
//
//  Created by Sandesh on 17/05/20.
//  Copyright © 2020 Sandesh. All rights reserved.
//

import Foundation
import UIKit

extension TopRatedMoviesVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchArray.removeAll()
        for item in realData{
            if (item.title.contains(searchBar.text!)) {
                self.searchArray.append(item)
            }
        }
        
        if searchText == "" {
            self.searchArray = self.realData
        }
        self.collectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchArray.removeAll()
        self.searchArray = self.realData
        self.collectionView.reloadData()
    }
}
