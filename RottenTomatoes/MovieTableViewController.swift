//
//  ViewController.swift
//  RottenTomatoes
//
//  Created by Jamie Tsao on 2/3/15.
//  Copyright (c) 2015 Jamie Tsao. All rights reserved.
//

import UIKit

class MovieTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // type of movie view (e.g. "In Theaters" vs "New Releases" (DVD))
    var viewType: String?

    // array of movies to display
    var movies: [Movie]?

    // refresh control
    var refreshControl: UIRefreshControl!

    // table view
    @IBOutlet weak var tableView: UITableView!
    
    // network error label
    @IBOutlet weak var networkErrorLabel: UILabel!

    // configures view type
    func setViewType(viewType type: String) {
        self.viewType = type;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // set this controller as dataSource and delegate of Table View
        tableView.dataSource = self
        tableView.delegate = self

        // set up UIRefreshControl
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        // load movies
        loadMovies(refreshing: false)
    }

    func onRefresh() {
        // load movies
        loadMovies(refreshing: true)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let array = movies {
            return array.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // dequeue cell for this row
        let cell = tableView.dequeueReusableCellWithIdentifier(Constants.IDs.MovieCell, forIndexPath: indexPath) as MovieTableViewCell

        // get corresponding movie for this row
        let movie = self.movies![indexPath.row]
        
        // set movie image (loaded asynchronously)
        cell.movieImage.setImageWithURL(NSURL(string: movie.getPosterUrlThumbSize()))
        
        // set movie title
        cell.movieTitle?.text = movie.title

        // set cast
        cell.abridgedCast!.text = movie.getAbridgedCastForShortDisplay()

        let criticsRating = movie.criticsScore
        if criticsRating < 0 {
            // this can happen if movie hasn't been released yet
            cell.criticsRatingImage.hidden = true
            cell.criticsRating.hidden = true
        } else {
            var img: UIImage!
            if criticsRating >= 60 {
                img = UIImage(named: Constants.ImageAssets.FreshTomatoe)
            } else {
                img = UIImage(named: Constants.ImageAssets.RottenTomatoe)
            }
            cell.criticsRatingImage.image = img
            cell.criticsRating!.text = "\(criticsRating)%"
            cell.criticsRatingImage.hidden = false
            cell.criticsRating.hidden = false
        }
        
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // get selected movie
        let movie = self.movies![indexPath.row]

        // instantiate details controller, set movie, then push
        let detailsController = self.storyboard?.instantiateViewControllerWithIdentifier(Constants.IDs.MovieDetailsViewController) as MovieDetailsViewController
        detailsController.movie = movie;
        self.navigationController?.pushViewController(detailsController, animated: true)
    }
    
    func loadMovies(refreshing refresh: Bool) {
        
        // success handler
        func onSuccess(movies: [Movie]) -> Void {
            self.networkErrorLabel.hidden = true
            self.movies = movies
            self.tableView.reloadData()
            MBProgressHUD.hideHUDForView(self.view, animated: true)
            if refresh {
                self.refreshControl.endRefreshing()
            }
        }

        // error handler
        func onError() -> Void {
            self.networkErrorLabel.hidden = false
            MBProgressHUD.hideHUDForView(self.view, animated: true)
            if refresh {
                self.refreshControl.endRefreshing()
            }
        }
        
        // show progress HUD before invoking API call
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)

        // invoke appropriate API based on viewTyp
        if self.viewType == Constants.MovieViewType.Theater {
            // make API call
            RottenTomatoesAPI.getMoviesInTheaters(
                successCallback: onSuccess,
                errorCallback: onError
            )
            
        } else if self.viewType == Constants.MovieViewType.DVD {
            // make API call
            RottenTomatoesAPI.getDVDsNewReleases(
                successCallback: onSuccess,
                errorCallback: onError
            )
        }
    }

}

