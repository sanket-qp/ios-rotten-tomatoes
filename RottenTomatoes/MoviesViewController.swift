//
//  MoviesViewController.swift
//  RottenTomatoes
//
//  Created by sanket patel on 9/12/14.
//  Copyright (c) 2014 sanket patel. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    
    var filteredMovies = [Movie]()
    
    let rottenClient = RottenClient(apiKey: "hfk7z5fdk8ab3eybk6hh8k9e")
    var refreshControl: UIRefreshControl!
    var movies: [Movie] = [] {

        didSet {
        
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        searchDisplayController.searchResultsDataSource = self
        searchDisplayController.searchResultsDelegate = self
        searchDisplayController.delegate = self
        searchDisplayController.searchResultsTableView.dataSource = self
        searchDisplayController.searchResultsTableView.delegate = self
        
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refersh")
        self.refreshControl.tintColor = UIColor.whiteColor()
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
        
        movies = rottenClient.getBoxOffice()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "refreshData:" , name: "moviesFetched", object: nil)
        
        let loading = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        loading.mode = MBProgressHUDModeCustomView
        loading.labelText = "Loading"
    }
    
    func refresh(sender: AnyObject) {
    
        movies = rottenClient.getBoxOffice()
        self.refreshControl.endRefreshing()
    }
    
    override func viewDidDisappear(animated: Bool) {

        super.viewDidDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func refreshData(sender: AnyObject) {
    
        movies = rottenClient.movies
        MBProgressHUD.hideAllHUDsForView(self.view, animated: true)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {

        if tableView == searchDisplayController!.searchResultsTableView {
        
            return self.filteredMovies.count
            
        } else {
        
            return movies.count
        }
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        
        var isSearch = (tableView == self.tableView) ? false : true
        var tView = isSearch ? self.tableView : tableView
        var cell = tView.dequeueReusableCellWithIdentifier("MovieCell") as MovieCell;
        var movie = isSearch ? self.filteredMovies[indexPath.row] : movies[indexPath.row]
        cell.titleLable.text = movie.title
        cell.synopsisLabel.text = movie.synopsis
        cell.posterView.setImageWithURL(NSURL(string: movie.thumbnail))
        cell.index = indexPath.row
        return cell
    }
    
    func searchDisplayController(controller: UISearchDisplayController!, didLoadSearchResultsTableView tableView: UITableView!) {
        
        tableView.rowHeight = self.tableView.rowHeight
        
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        
        let index = indexPath.row

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {


        if segue.identifier == "MovieDetailSegue" {
            
            let detailsController = segue.destinationViewController as DetailViewController
            var movies = searchDisplayController.active ? self.filteredMovies : self.movies
            if let movieCell = sender as? MovieCell {
                
                var bgColorView = UIView()
                bgColorView.backgroundColor = UIColor.grayColor()
                movieCell.selectedBackgroundView = bgColorView
                detailsController.movie = movies[movieCell.index]
            }
        }
    }
    
    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchString searchString: String!) -> Bool {
        
        self.filterMovies(searchString)
        println(self.filteredMovies)
        return true
    }
    
    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchScope searchOption: Int) -> Bool {

        self.filterMovies(searchDisplayController!.searchBar.text)
        println("reload table scope")
        return false
    }
    
    func filterMovies(searchText: String){
    
        println("searching for \(searchText)")
        self.filteredMovies = self.movies.filter({
            (movie: Movie) -> Bool in
                let stringMatch = movie.title.rangeOfString(searchText, options: nil, range: nil, locale: nil)
                return stringMatch != nil
        })
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
