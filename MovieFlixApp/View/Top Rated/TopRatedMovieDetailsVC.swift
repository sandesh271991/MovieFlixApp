//
//  TopRatedMovieDetailsVC.swift
//  MovieFlixApp
//
//  Created by Sandesh on 17/05/20.
//  Copyright © 2020 Sandesh. All rights reserved.
//

import UIKit

class TopRatedMovieDetailsVC: UIViewController {

    var movieDetails: TopRatedMoviesResult?
    
    @IBOutlet weak var imgMovieBG: UIImageView!
    @IBOutlet weak var lblMovieOverview: UILabel!
    @IBOutlet weak var lblMovieTitle: UILabel!
    @IBOutlet weak var lblVoteAvg: UILabel!
    @IBOutlet weak var lblReleaseDate: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imgMovieBG.loadImageUsingCache(withUrl: IMAGE_PATH + "\(movieDetails?.posterPath ?? "")")
        lblMovieTitle.text = movieDetails?.title
        lblMovieOverview.text = movieDetails?.overview
        if let voteAvg = movieDetails?.voteAverage {
            lblVoteAvg.text = "\(voteAvg)"
        }
        lblReleaseDate.text = movieDetails?.releaseDate
    }
}
