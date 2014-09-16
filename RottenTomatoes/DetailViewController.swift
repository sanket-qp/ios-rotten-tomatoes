//
//  DetailViewController.swift
//  RottenTomatoes
//
//  Created by sanket patel on 9/15/14.
//  Copyright (c) 2014 sanket patel. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var uiView: UIView!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var movie: Movie! {
        
        didSet {
            
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.backgroundColor = .clearColor()
        self.navigationItem.backBarButtonItem = UIBarButtonItem()
        self.navigationItem.backBarButtonItem.tintColor = .orangeColor()

        // Do any additional setup after loading the view.
        if let thumbnail = movie?.thumbnail {
            
            posterImage.setImageWithURL(NSURL(string: movie?.thumbnail))
        }
        
        if let detailed = movie?.detailed {
            
            posterImage.setImageWithURL(NSURL(string: movie?.detailed))
        }
        
        if let synopsis = movie?.synopsis {
            
            scrollView.contentSize = CGSizeMake(320, 650);
            //scrollView.contentSize = CGSizeMake(width, height);
            //titleLabel.text = movie?.title
            synopsisLabel.text = synopsis

        }
        
        
        if let score = movie?.score {
        
            scoreLabel.text = score
        }
        
        if let title = movie?.title {
        
            self.navigationItem.title = title
            titleLabel.text = title
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
