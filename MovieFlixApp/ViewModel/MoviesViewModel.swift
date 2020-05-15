//
//  MoviesViewModel.swift
//  
//
//  Created by Sandesh on 14/05/20.
//


import Foundation
import UIKit

class MoviesViewModel: NSObject {
    var moviesData: Movies?
    
    var result: [Result] {
        return moviesData?.results ?? []
    }
    
    init(moviesdata: Movies) {
        self.moviesData = moviesdata
    }
}
