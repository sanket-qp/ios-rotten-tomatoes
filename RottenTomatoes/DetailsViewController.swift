//
//  DetailsViewController.swift
//  RottenTomatoes
//
//  Created by sanket patel on 9/15/14.
//  Copyright (c) 2014 sanket patel. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var navigationTitle: UINavigationItem!
    @IBOutlet weak var mpaaRating: UILabel!
    
    var movie: Movie! {
        
        didSet {
            
            navigationTitle.title = movie?.title
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let thumbnail = movie?.thumbnail {
            
            posterView.setImageWithURL(NSURL(string: movie?.thumbnail))
        }
        
        if let detailed = movie?.detailed {
            
            posterView.setImageWithURL(NSURL(string: movie?.detailed))
        }
        
        if let mRating = movie?.mpaaRating {
            
            mpaaRating.text = mRating
        }
        
        if let score = movie?.score {
        
            ratingLabel.text = score
        }
        
        if let synopsis = movie?.synopsis {
            
            var height = posterView.frame.size.height
            var width = posterView.frame.size.width
            scrollView.contentSize = CGSizeMake(320, 600);
            //scrollView.contentSize = CGSizeMake(width, height);
            titleLabel.text = movie?.title
            synopsisLabel.text = synopsis
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
