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
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var smallImageView: UIImageView!
    @IBOutlet weak var descLabel: UILabel!
    
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
        

            var height = posterImageView.frame.size.height
            var width = posterImageView.frame.size.width
            println(height)
            println(width)
            
            
            //scrollView.contentSize = CGSizeMake(320, 700);
            scrollView.contentSize = CGSizeMake(width, height)
            smallImageView.setImageWithURL(NSURL(string: movie?.thumbnail))
            descLabel.text = synopsis
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func canBecomeFirstResponder() -> Bool {
        return true
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
