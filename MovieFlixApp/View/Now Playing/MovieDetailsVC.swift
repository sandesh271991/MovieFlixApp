//
//  MovieDetailsVC.swift
//  MovieFlixApp
//
//  Created by Sandesh on 16/05/20.
//  Copyright © 2020 Sandesh. All rights reserved.
//

import UIKit

class MovieDetailsVC: UIViewController {

    var movieDetails: Result?
    var topRatedMovieDetails: TopRatedMoviesResult?
    
    var from:String?

    @IBOutlet weak var imgMovieBG: UIImageView!
    @IBOutlet weak var lblMovieOverview: UILabel!
    @IBOutlet weak var lblMovieTitle: UILabel!
    @IBOutlet weak var lblVoteAvg: UILabel!
    @IBOutlet weak var lblReleaseDate: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if from == "one"{
            imgMovieBG.loadImageUsingCache(withUrl: IMAGE_PATH + "\(movieDetails?.posterPath ?? "")")
            lblMovieTitle.text = movieDetails?.title
            lblMovieOverview.text = movieDetails?.overview
            if let voteAvg = movieDetails?.voteAverage {
                lblVoteAvg.text = "\(voteAvg)"
            }
            lblReleaseDate.text = movieDetails?.releaseDate
        }
        else{
            imgMovieBG.loadImageUsingCache(withUrl: IMAGE_PATH + "\(topRatedMovieDetails?.posterPath ?? "")")
            lblMovieTitle.text = topRatedMovieDetails?.title
            lblMovieOverview.text = topRatedMovieDetails?.overview
            if let voteAvg = topRatedMovieDetails?.voteAverage {
                lblVoteAvg.text = "\(voteAvg)"
            }
            lblReleaseDate.text = topRatedMovieDetails?.releaseDate
        }

    }
}
