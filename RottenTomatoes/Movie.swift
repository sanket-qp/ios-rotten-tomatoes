//
//  Movie.swift
//  RottenTomatoes
//
//  Created by sanket patel on 9/13/14.
//  Copyright (c) 2014 sanket patel. All rights reserved.
//

import Foundation
class Movie {

    let title: String
    let synopsis: String
    let posters: NSDictionary
    let thumbnail: String
    let detailed: String
    
    init(title: String, synopsis: String, posters: NSDictionary) {
    
        self.title = title
        self.synopsis = synopsis
        self.posters = posters
        
        var thumbnail  = posters["thumbnail"] as String

        // hack, replace _tmb with _pro
        self.thumbnail = thumbnail.stringByReplacingOccurrencesOfString("tmb", withString: "pro")
        
        var detailed = posters["original"] as String
        self.detailed = detailed.stringByReplacingOccurrencesOfString("tmb", withString: "ori")
    }
}