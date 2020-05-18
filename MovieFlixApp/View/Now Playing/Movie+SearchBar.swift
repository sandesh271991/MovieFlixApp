//
//  Movie+SearchBar.swift
//  MovieFlixApp
//
//  Created by Sandesh on 16/05/20.
//  Copyright © 2020 Sandesh. All rights reserved.
//

import Foundation
import UIKit

extension MovieNowShowing:  UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if fromScreen == "one"{
            self.moviesSearchList.removeAll()
            for item in moviesList{
                if (item.title.contains(searchBar.text!)) {
                    self.moviesSearchList.append(item)
                }
            }
            
            if searchText == "" {
                self.moviesSearchList = self.moviesList
            }
        }
        else{
            self.topRatedMoviesSearchList.removeAll()
            for item in topRatedMoviesList{
                if (item.title.contains(searchBar.text!)) {
                    self.topRatedMoviesSearchList.append(item)
                }
            }
            
            if searchText == "" {
                self.topRatedMoviesSearchList = self.topRatedMoviesList
            }
        }
        
        self.collectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        if fromScreen == "one" {
            self.moviesSearchList.removeAll()
            self.moviesSearchList = self.moviesList
        }
        else{
            self.topRatedMoviesSearchList.removeAll()
            self.topRatedMoviesSearchList = self.topRatedMoviesList
        }

        
        self.collectionView.reloadData()
        searchBar.resignFirstResponder()

    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
