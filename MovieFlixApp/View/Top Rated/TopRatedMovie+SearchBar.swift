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
        self.moviesSearchList.removeAll()
        for item in moviesList{
            if (item.title.contains(searchBar.text!)) {
                self.moviesSearchList.append(item)
            }
        }
        
        if searchText == "" {
            self.moviesSearchList = self.moviesList
        }
        self.collectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.moviesSearchList.removeAll()
        self.moviesSearchList = self.moviesList
        self.collectionView.reloadData()
    }
}
