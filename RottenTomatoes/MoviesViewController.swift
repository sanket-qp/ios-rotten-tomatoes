//
//  MoviesViewController.swift
//  RottenTomatoes
//
//  Created by sanket patel on 9/12/14.
//  Copyright (c) 2014 sanket patel. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    let rottenClient = RottenClient(apiKey: "hfk7z5fdk8ab3eybk6hh8k9e")
    var movies: [Movie] = [] {

        didSet {
        
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        movies = rottenClient.getBoxOffice()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "refreshData:" , name: "moviesFetched", object: nil)
    }
    
    override func viewDidDisappear(animated: Bool) {

        super.viewDidDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func refreshData(sender: AnyObject) {
    
        movies = rottenClient.movies
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
    
        return movies.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("MovieCell") as MovieCell;
        var movie = movies[indexPath.row]
        cell.titleLable.text = movie.title
        cell.synopsisLabel.text = movie.synopsis
        cell.posterView.setImageWithURL(NSURL(string: movie.thumbnail))
        return cell;
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