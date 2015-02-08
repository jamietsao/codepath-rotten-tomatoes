//
//  MovieDetailsViewController.swift
//  RottenTomatoes
//
//  Created by Jamie Tsao on 2/4/15.
//  Copyright (c) 2015 Jamie Tsao. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    var movie: Movie?
    
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var abridgedCast: UILabel!
    @IBOutlet weak var movieImage: UIImageView!

    @IBOutlet weak var criticScoreImage: UIImageView!
    @IBOutlet weak var criticScore: UILabel!
    @IBOutlet weak var criticScoreNoneLabel: UILabel!
    @IBOutlet weak var userScoreImage: UIImageView!
    @IBOutlet weak var userScore: UILabel!
    @IBOutlet weak var userScoreNoneLabel: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var rated: UILabel!
    @IBOutlet weak var runningTime: UILabel!
    @IBOutlet weak var synopsis: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // movie title
        movieTitle!.text = movie!.title

        // abridged cast
        abridgedCast!.text = movie!.getAbridgedCastForFullDisplay()

        // poster image (loaded asynchronously)
        movieImage.setImageWithURL(NSURL(string: movie!.getPosterUrlOriginalSize()))
        
        // critic score
        let criticRating = movie!.criticsScore
        if criticRating < 0 {
            // this can happen if movie hasn't been released yet
            criticScoreImage.hidden = true
            criticScore.hidden = true
            criticScoreNoneLabel.hidden = false
        } else {
            var img: UIImage!
            if criticRating >= 60 {
                img = UIImage(named: Constants.ImageAssets.FreshTomatoe)
            } else {
                img = UIImage(named: Constants.ImageAssets.RottenTomatoe)
            }
            criticScoreImage.image = img
            criticScore!.text = "\(criticRating)%"
            criticScoreImage.hidden = false
            criticScore.hidden = false
            criticScoreNoneLabel.hidden = true
        }

        // user score
        let userRating = movie!.audienceScore
        if userRating < 0 {
            // this can happen if movie hasn't been released yet
            userScoreImage.hidden = true
            userScore.hidden = true
            userScoreNoneLabel.hidden = false
        } else {
            var img: UIImage!
            if userRating >= 60 {
                img = UIImage(named: Constants.ImageAssets.FreshPopcorn)
            } else {
                img = UIImage(named: Constants.ImageAssets.SpiltPopocorn)
            }
            userScoreImage.image = img
            userScore!.text = "\(userRating)%"
            userScoreImage.hidden = false
            userScore.hidden = false
            userScoreNoneLabel.hidden = true
        }

        // year, rated, running time
        year!.text = String(movie!.year)
        rated!.text = movie!.rating
        runningTime!.text = movie!.getRuntimeForDisplay()

        // synopsis
        synopsis?.text = movie!.synopsis
        // NOTE: found a solution to vertically align text at the top (http://iostechsolutions.blogspot.com/2014/04/uilabel-top-aligned-align-text-to-top.html)
        synopsis?.numberOfLines = 0
        synopsis?.sizeToFit()
    }

}
