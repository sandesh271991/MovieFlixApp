//
//  ViewController.swift
//  MovieFlixApp
//
//  Created by Sandesh on 14/05/20.
//  Copyright © 2020 Sandesh. All rights reserved.
//

import UIKit

class MovieNowShowing: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var searchArray = [Result]()
    var realData = [Result]()
    var moviesViewModel: MoviesViewModel?
    var movieData: Movies? {
        
        didSet {
            guard let movieData = movieData else { return }
            moviesViewModel = MoviesViewModel.init(moviesdata: movieData)
            searchArray = moviesViewModel?.result ?? []
            realData = moviesViewModel?.result ?? []
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    //MARK: View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getMoviesData()
        searchBar()
    }
    
    
    //MARK: UI
    func searchBar(){
        self.navigationItem.searchController = UISearchController(searchResultsController: nil)
        self.navigationItem.searchController?.searchBar.delegate = self
        self.definesPresentationContext = true
    }
    
    
    //MARK: To Get Movie Data
    func getMoviesData(){
        if isConnectedToInternet() == true {
            Webservice.shared.getData(with: BASE_URL_NOW_SHOWING_MOVIE + "api_key=" + API_KEY ) { (moviesData, error) in
                if error != nil {
                    return
                }
                guard let moviesData = moviesData else {return}
                self.movieData = moviesData
            }
        }
        else{
            showAlert(title: "No Internet Connection", message: "Please check your internet connection")
        }
    }
    
    
    //MARK: To Remove Movie
    @objc func swipeToDelete(sender: UISwipeGestureRecognizer) {
        let cell = sender.view as! UICollectionViewCell
        let itemIndex = self.collectionView.indexPath(for: cell)!.item
        searchArray.remove(at: itemIndex)
        self.realData = self.searchArray
        self.collectionView.reloadData()
        showAlert(title: "Movie Deleted", message: "")

    }
    
    @IBAction func deleteButtonTapped(sender: UIButton)  -> Void {
        let cell = sender.superview as! UICollectionViewCell
        let itemIndex = self.collectionView.indexPath(for: cell)!.item
        searchArray.remove(at: itemIndex)
        self.realData = self.searchArray
        self.collectionView.reloadData()
        showAlert(title: "Movie Deleted", message: "")
    }
}

