//
//  TopRatedMoviesViewModel.swift
//  MovieFlixApp
//
//  Created by Sandesh on 15/05/20.
//  Copyright © 2020 Sandesh. All rights reserved.
//

import Foundation
import UIKit

class TopRatedMoviesViewModel: NSObject {
    var topratedMoviesData: TopRatedMovies?
    
    var result: [TopRatedMoviesResult] {
        return topratedMoviesData?.results ?? []
    }
    
    init(topratedMoviesData: TopRatedMovies) {
        self.topratedMoviesData = topratedMoviesData
    }
}
