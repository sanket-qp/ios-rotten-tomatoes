//
//  RottenClient.swift
//  RottenTomatoes
//
//  Created by sanket patel on 9/13/14.
//  Copyright (c) 2014 sanket patel. All rights reserved.
//

import Foundation

class RottenClient {

    var apiKey: String
    let moviesEndpoint = "http://api.rottentomatoes.com/api/public/v1.0/lists/movies"
    var movies: [Movie] = [] {
    
        didSet {
            
            // notify observers when movie list is fetched
            NSNotificationCenter.defaultCenter().postNotificationName("moviesFetched", object: self)
        }
    }
    
    init(apiKey: String) {
    
        self.apiKey = apiKey
    }

    func getBoxOffice() -> [Movie] {
    
        return getMovies("box_office.json");
    }
    
    func getUpComing() -> [Movie] {

        return getMovies("upcoming.json");
    }
    
    func getInTheatres() -> [Movie] {
    
        return getMovies("in_theatres.json");
    }
    
    func getOpening() -> [Movie] {
    
        return getMovies("opening.json");
    }
    
    func getMovies(category:String, limit:Int = 10) -> [Movie]{
    
        var uri = "\(moviesEndpoint)/\(category)?apiKey=\(apiKey)&limit=\(limit)"
        var req = NSURLRequest(URL: NSURL(string: uri))
        NSURLConnection.sendAsynchronousRequest(req, queue: NSOperationQueue.mainQueue()) {
            (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in

            var object = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
            var movies = object["movies"] as [NSDictionary]
            let m = movies.map({(movie: NSDictionary) -> Movie in
            
                Movie(title: movie["title"] as String, synopsis: movie["synopsis"] as String, posters: movie["posters"] as NSDictionary)
            })
            
            self.movies = m
        }
        
        return movies
    }
}