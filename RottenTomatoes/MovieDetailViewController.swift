//
//  MovieDetailViewController.swift
//  RottenTomatoes
//
//  Created by sanket patel on 9/13/14.
//  Copyright (c) 2014 sanket patel. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

 
    @IBOutlet weak var titleLabel: UINavigationItem!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!

    var movie: Movie! {
    
        didSet {
        
            titleLabel.title = movie?.title

        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let thumbnail = movie?.thumbnail {
            
            posterImageView.setImageWithURL(NSURL(string: movie?.thumbnail))
        }
        
        if let detailed = movie?.detailed {
            
            posterImageView.setImageWithURL(NSURL(string: movie?.detailed))
        }
        
        if let synopsis = movie?.synopsis {
        
            descriptionLabel.text = movie.synopsis
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
