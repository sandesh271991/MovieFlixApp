//
//  Webservice.swift
//  MovieFlixApp
//
//  Created by Sandesh on 14/05/20.
//  Copyright © 2020 Sandesh. All rights reserved.
//

import Foundation
import Alamofire


//Now Playing
class Webservice: NSObject {
    static let shared = Webservice()
    func getData(with url: String, completion:@escaping (_ data: Movies?, _ error: Error?) -> Void) {
        AF.request(url).responseData { (responseData) in
            switch responseData.result {
            case .success(let data):
                //Apply string encoding as response is not UTF 8 formatted
                let string = String(decoding: data, as: UTF8.self)
                if let datastr = string.data(using: String.Encoding.utf8) {
                    //Map response data into model
                    do {
                        let moviesData = try JSONDecoder().decode(Movies.self, from: datastr)
                        completion(moviesData, nil)
                    } catch let error as NSError {
                        print(error)
                        completion(nil, error)
                    }
                }
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func getTopRatedMoviesData(with url: String, completion:@escaping (_ data: TopRatedMovies?, _ error: Error?) -> Void) {
        AF.request(url).responseData { (responseData) in
            switch responseData.result {
            case .success(let data):
                //Apply string encoding as response is not UTF 8 formatted
                let string = String(decoding: data, as: UTF8.self)
                if let datastr = string.data(using: String.Encoding.utf8) {
                    //Map response data into model
                    do {
                        let moviesData = try JSONDecoder().decode(TopRatedMovies.self, from: datastr)
                        completion(moviesData, nil)
                    } catch let error as NSError {
                        print(error)
                        completion(nil, error)
                    }
                }
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}



//Top rated


extension UILabel{

public var requiredHeight: CGFloat {
    let label = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: CGFloat.greatestFiniteMagnitude))
    label.numberOfLines = 0
    label.lineBreakMode = NSLineBreakMode.byWordWrapping
    label.font = font
    label.text = text
    label.attributedText = attributedText
    label.sizeToFit()
    return label.frame.height
  }
}
