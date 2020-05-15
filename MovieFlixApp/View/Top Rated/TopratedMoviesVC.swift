//
//  TopratedMoviesVC.swift
//  MovieFlixApp
//
//  Created by Sandesh on 15/05/20.
//  Copyright © 2020 Sandesh. All rights reserved.
//


import UIKit

class TopratedMoviesVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    var moviesViewModel: TopRatedMoviesViewModel?
    var movieData: TopRatedMovies? {
        
        didSet {
            guard let movieData = movieData else { return }
            moviesViewModel = TopRatedMoviesViewModel.init(topratedMoviesData: movieData)
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

       Webservice.shared.getTopRatedMoviesData(with: "https://api.themoviedb.org/3/movie/top_rated?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed") { (moviesData, error) in
           // self.refreshControl?.endRefreshing()
            if error != nil {
                return
            }
            guard let moviesData = moviesData else {return}
            self.movieData = moviesData
        }
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
        return moviesViewModel?.result.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopRatedMovieCellID", for: indexPath) as? TopRatedMovieCell {
            
            cell.imgMovie.layer.masksToBounds = false
            cell.imgMovie.layer.cornerRadius = 5
            
            cell.lblMovieName.text = "\(String(describing: moviesViewModel?.result[indexPath.section].title))"
            
            cell.imgMovie.loadImageUsingCache(withUrl: "https://image.tmdb.org/t/p/w342/4XzbcAKdX4n3aWfzBjjeAlm68S3.jpg")
//            cell.imgMovie.image = UIImage(named: "https://image.tmdb.org/t/p/w342/4XzbcAKdX4n3aWfzBjjeAlm68S3.jpg")
            cell.lblMovieDescription.text = "\(String(describing: moviesViewModel?.result[indexPath.section].overview))"
            return cell
        } else {
            return UICollectionViewCell()
        }
    }

    func createCustomLayout() -> UICollectionViewLayout {
            
            let layout = UICollectionViewCompositionalLayout { (section: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in

                let leadingItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: NSCollectionLayoutDimension.fractionalWidth(1.0), heightDimension: .estimated(100.0)))
                leadingItem.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
                let leadingGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7), heightDimension: .fractionalHeight(1))
                let leadingGroup = NSCollectionLayoutGroup.vertical(layoutSize: leadingGroupSize, subitem: leadingItem, count: 1)
                
//                let trailingItem =  NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: NSCollectionLayoutDimension.fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
//                trailingItem.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
//                let trailingGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(1))
//
//                let trailingGroup =  NSCollectionLayoutGroup.vertical(layoutSize: trailingGroupSize, subitem: trailingItem, count: 2)
                
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
