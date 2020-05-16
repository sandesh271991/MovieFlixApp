//
//  ViewController.swift
//  MovieFlixApp
//
//  Created by Sandesh on 14/05/20.
//  Copyright © 2020 Sandesh. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var searchArray = [Result]()
    var realData = [Result]()
    
    @IBOutlet weak var searchBar: UISearchBar!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCustomLayout())
        //        collectionView.backgroundColor = .white
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        Webservice.shared.getData(with: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed") { (moviesData, error) in
            // self.refreshControl?.endRefreshing()
            if error != nil {
                return
            }
            guard let moviesData = moviesData else {return}
            self.movieData = moviesData
        }
        self.navigationItem.searchController = UISearchController(searchResultsController: nil)
        self.navigationItem.searchController?.searchBar.delegate = self
        self.definesPresentationContext = true
        
    }
    
    func configureCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ])
    }
    
    func numberOfSections(in collectionView: UICollectionView) ->  Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchArray.count
    }
    
    @IBAction func editButtonTapped(sender: UIButton)  -> Void {
        let cell = sender.superview as! UICollectionViewCell
        let itemIndex = self.collectionView.indexPath(for: cell)!.item
        searchArray.remove(at: itemIndex)
        self.collectionView.reloadData()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as? MovieCell {
            
            
            cell.lblMovieName.text = "\(String(describing: searchArray[indexPath.row].title))"
            cell.imgMovie.loadImageUsingCache(withUrl: "https://image.tmdb.org/t/p/w342\(String(describing: searchArray[indexPath.row].posterPath))")
            
            cell.lblMovieDescription.text = "\(String(describing: searchArray[indexPath.row].overview))"
            
            let UpSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeToDelete))
            UpSwipe.direction = UISwipeGestureRecognizer.Direction.left
            cell.addGestureRecognizer(UpSwipe)
            
            
            let editButton = UIButton(frame: CGRect(x: cell.bounds.width - 50, y: (cell.bounds.height) - 50 , width: 50, height: 50))
            editButton.setBackgroundImage(UIImage(systemName: "xmark.circle.fill"), for: UIControl.State.normal)
            editButton.tintColor = .red
            editButton.addTarget(self, action: #selector(editButtonTapped), for: UIControl.Event.touchUpInside)
            editButton.tag = indexPath.row
            editButton.isUserInteractionEnabled = true
            
            cell.addSubview(editButton)
            
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    @objc func swipeToDelete(sender: UISwipeGestureRecognizer) {
        let cell = sender.view as! UICollectionViewCell
        let itemIndex = self.collectionView.indexPath(for: cell)!.item
        searchArray.remove(at: itemIndex)
        self.collectionView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchArray.removeAll()
        for item in moviesViewModel?.result ?? []{
            if (item.title.contains(searchBar.text!)) {
                self.searchArray.append(item)
            }
        }
        self.collectionView.reloadData()
    }    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchArray.removeAll()
        self.searchArray = self.realData
        self.collectionView.reloadData()
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

    
    func createCustomLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout { (section: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let leadingItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: NSCollectionLayoutDimension.fractionalWidth(1.0), heightDimension: .estimated(100.0)))
            leadingItem.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
            let leadingGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7), heightDimension: .fractionalHeight(1))
            let leadingGroup = NSCollectionLayoutGroup.vertical(layoutSize: leadingGroupSize, subitem: leadingItem, count: 1)
            
            
            let containerGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),  heightDimension: .absolute(250))
            
            let containerGroup = NSCollectionLayoutGroup.vertical(layoutSize: containerGroupSize, subitems: [leadingGroup])
            
            
            let section = NSCollectionLayoutSection(group: containerGroup)
            section.orthogonalScrollingBehavior = .continuous
            section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0)
            
            return section
        }
        return layout
    }
}

