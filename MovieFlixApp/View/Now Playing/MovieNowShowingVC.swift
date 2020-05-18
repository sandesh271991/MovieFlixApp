//
//  ViewController.swift
//  MovieFlixApp
//
//  Created by Sandesh on 14/05/20.
//  Copyright © 2020 Sandesh. All rights reserved.
//

import UIKit

class MovieNowShowing: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.collectionViewLayout = createCollectionViewLayout()
        }
    }
    @IBOutlet weak var searchBar: UISearchBar!
    
    var fromScreen: String?
    
    var refreshControl: UIRefreshControl?
    
    var moviesSearchList = [Result]()
    var moviesList = [Result]()
    
    var topRatedMoviesSearchList = [TopRatedMoviesResult]()
    var topRatedMoviesList = [TopRatedMoviesResult]()
    
    
    var moviesViewModel: MoviesViewModel?
    var movieData: Movies? {
        
        didSet {
            guard let movieData = movieData else { return }
            moviesViewModel = MoviesViewModel.init(moviesdata: movieData)
            moviesSearchList = moviesViewModel?.result ?? []
            moviesList = moviesViewModel?.result ?? []
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    
    var topRatedMoviesViewModel: TopRatedMoviesViewModel?
    var topRatedMovieData: TopRatedMovies? {
        
        didSet {
            guard let movieData = topRatedMovieData else { return }
            topRatedMoviesViewModel = TopRatedMoviesViewModel(topratedMoviesData: movieData)
            topRatedMoviesSearchList = topRatedMoviesViewModel?.result ?? []
            topRatedMoviesList = topRatedMoviesViewModel?.result ?? []
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    
    
    //MARK: View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if fromScreen == "one" {
            print("From one screen")
        }
        if fromScreen == "two" {
            print("From two screen")
        }
        
        
        getMoviesData()
        refresh()
    }
    
    //MARK: UI
//    func searchBar(){
//        self.navigationItem.searchController = UISearchController(searchResultsController: nil)
//        self.navigationItem.searchController?.searchBar.delegate = self
//        self.definesPresentationContext = true
//    }
    
    //MARK: Refresh
    func refresh(){
        self.refreshControl = UIRefreshControl.init()
        self.refreshControl?.addTarget(self, action: #selector(getMoviesData), for: .valueChanged)
        self.collectionView?.addSubview(refreshControl!)
    }
    
    //MARK: To Get Movie Data
    @objc func getMoviesData(){
        if isConnectedToInternet() == true {
            
            if fromScreen == "one" {
                Webservice.shared.getMovieData(with: BASE_URL_NOW_SHOWING_MOVIE + "api_key=" + API_KEY ) { (moviesData, error) in
                    
                    self.refreshControl?.endRefreshing()
                    if error != nil {
                        self.showAlert(title: "Something went wrong", message: "Please check your internet connection or try later")
                        return
                    }
                    guard let moviesData = moviesData else {return}
                    self.movieData = moviesData
                }
                
            }
            else{
                Webservice.shared.getTopRatedMoviesData(with: BASE_URL_TOP_RATED_MOVIE + "api_key=" + API_KEY ) { (moviesData, error) in
                    
                    self.refreshControl?.endRefreshing()
                    if error != nil {
                        self.showAlert(title: "Something went wrong", message: "Please check your internet connection or try later")
                        return
                    }
                    guard let moviesData = moviesData else {return}
                    self.topRatedMovieData = moviesData
                }
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
        
        if fromScreen == "one" {
            showAlert(title: "Movie - \(moviesSearchList[itemIndex].title) - Deleted", message: "")
            self.collectionView.performBatchUpdates({
                collectionView.deleteItems(at: [(NSIndexPath(item: itemIndex, section: 0) as IndexPath)])
                moviesSearchList.remove(at: itemIndex)
            }, completion: nil)
            self.moviesList = self.moviesSearchList

        }
        else{
            showAlert(title: "Movie - \(topRatedMoviesSearchList[itemIndex].title) - Deleted", message: "")
            self.collectionView.performBatchUpdates({
                collectionView.deleteItems(at: [(NSIndexPath(item: itemIndex, section: 0) as IndexPath)])
                topRatedMoviesSearchList.remove(at: itemIndex)
            }, completion: nil)
            self.topRatedMoviesList = self.topRatedMoviesSearchList
        }   
    }
    
    //MARK: Compositional Collection View
    private func createCollectionViewLayout() -> UICollectionViewLayout {
        // Define Item Size
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(200.0))
        
        // Create Item
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // Define Group Size
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(200.0))
        
        // Create Group
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [ item ])
        
        // Create Section
        let section = NSCollectionLayoutSection(group: group)
        
        // Configure Section
        section.contentInsets = NSDirectionalEdgeInsets(top: 0.0, leading: 0.0, bottom: 0.0, trailing: 0.0)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
}

