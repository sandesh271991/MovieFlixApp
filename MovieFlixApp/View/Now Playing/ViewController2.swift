//
//  ViewController2.swift
//  MovieFlixApp
//
//  Created by Sandesh on 17/05/20.
//  Copyright © 2020 Sandesh. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "views" {
            let destVC = segue.destination as! MovieNowShowing
            destVC.fromScreen = "two"
        }
    }
}
