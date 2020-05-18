//
//  ViewController1.swift
//  MovieFlixApp
//
//  Created by Sandesh on 17/05/20.
//  Copyright © 2020 Sandesh. All rights reserved.
//

import UIKit

class MovieNowShowing: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromNowPlaying" {
            let destVC = segue.destination as! CommonVC
            destVC.fromScreen = FROM_NOW_PLAYING
        }
    }
}
