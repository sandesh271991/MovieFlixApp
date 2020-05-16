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
    
    @IBOutlet weak var imgMovieBG: UIImageView!
    
    @IBOutlet weak var lblMovieOverview: UILabel!
    @IBOutlet weak var lblMovieTitle: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        imgMovieBG.loadImageUsingCache(withUrl: "https://image.tmdb.org/t/p/w342/\(movieDetails?.posterPath ?? "")")
        lblMovieTitle.text = movieDetails?.title
        lblMovieOverview.text = movieDetails?.overview
        print("https://image.tmdb.org/t/p/w342/\(movieDetails?.posterPath ?? "")")
        // Do any additional setup after loading the view.
    }


}
