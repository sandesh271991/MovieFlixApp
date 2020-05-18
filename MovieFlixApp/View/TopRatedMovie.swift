//
//  TopRatedMovie.swift
//  MovieFlixApp
//
//  Created by Sandesh on 17/05/20.
//  Copyright © 2020 Sandesh. All rights reserved.
//

import UIKit

class TopRatedMovie: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromTopRated" {
            let destVC = segue.destination as! CommonVC
            destVC.fromScreen = FROM_TOP_RATED
        }
    }
}
