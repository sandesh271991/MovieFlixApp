//
//  Movie+Tableview.swift
//  MovieFlixApp
//
//  Created by Sandesh on 16/05/20.
//  Copyright © 2020 Sandesh. All rights reserved.
//

import Foundation
import UIKit

extension MovieNowShowing:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20.0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if fromScreen == "one"{
            return moviesSearchList.count
        }
        else{
            return topRatedMoviesSearchList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as? MovieNowPlayingCell {
            
            if fromScreen == "one" {
                cell.lblMovieName.text = "\(String(describing: moviesSearchList[indexPath.row].title))"
                cell.imgMovie.loadImageUsingCache(withUrl: IMAGE_PATH + "\(String(describing: moviesSearchList[indexPath.row].posterPath))")
                cell.lblMovieDescription.text = "\(String(describing: moviesSearchList[indexPath.row].overview))"
            }
            else{
                cell.lblMovieName.text = "\(String(describing: topRatedMoviesSearchList[indexPath.row].title))"
                cell.imgMovie.loadImageUsingCache(withUrl: IMAGE_PATH + "\(String(describing: topRatedMoviesSearchList[indexPath.row].posterPath))")
                cell.lblMovieDescription.text = "\(String(describing: topRatedMoviesSearchList[indexPath.row].overview))"
            }

            
            //Swipe to Delete
            let UpSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeToDelete))
            UpSwipe.direction = UISwipeGestureRecognizer.Direction.left
            cell.addGestureRecognizer(UpSwipe)
            
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    internal func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
        let movieDetailsVC = self.storyboard?.instantiateViewController(identifier: "MovieDetailsVC") as! MovieDetailsVC
        if fromScreen == "one"{
            movieDetailsVC.from = "one"
            movieDetailsVC.movieDetails = moviesSearchList[indexPath.row]
        }
        else{
            movieDetailsVC.from = "two"
            movieDetailsVC.topRatedMovieDetails = topRatedMoviesSearchList[indexPath.row]
        }
        self.navigationController?.pushViewController(movieDetailsVC, animated: true)
    }
}
