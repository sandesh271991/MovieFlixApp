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
    override func viewDidLoad() {
        super.viewDidLoad()

        print(movieDetails?.title)
        // Do any additional setup after loading the view.
    }


}
