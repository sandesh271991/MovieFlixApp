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
        return searchArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as? MovieNowPlayingCell {
            
            cell.lblMovieName.text = "\(String(describing: searchArray[indexPath.row].title))"
            cell.imgMovie.loadImageUsingCache(withUrl: IMAGE_PATH + "\(String(describing: searchArray[indexPath.row].posterPath))")
            cell.lblMovieDescription.text = "\(String(describing: searchArray[indexPath.row].overview))"
            
            //Swipe to Delete
            let UpSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeToDelete))
            UpSwipe.direction = UISwipeGestureRecognizer.Direction.left
            cell.addGestureRecognizer(UpSwipe)
            
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let kWhateverHeightYouWant = 400
        
        return CGSize(width: collectionView.bounds.size.width, height: CGFloat(kWhateverHeightYouWant))
    }
    
    internal func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
        let movieDetailsVC = self.storyboard?.instantiateViewController(identifier: "MovieDetailsVC") as! MovieDetailsVC
        movieDetailsVC.movieDetails = searchArray[indexPath.row]
        self.navigationController?.pushViewController(movieDetailsVC, animated: true)
    }
}
