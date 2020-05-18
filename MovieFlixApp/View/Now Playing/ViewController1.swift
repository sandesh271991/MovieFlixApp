//
//  ViewController1.swift
//  MovieFlixApp
//
//  Created by Sandesh on 17/05/20.
//  Copyright © 2020 Sandesh. All rights reserved.
//

import UIKit

class ViewController1: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "view" {
            let destVC = segue.destination as! MovieNowShowing
            destVC.fromScreen = "one"
        }
    }

}
