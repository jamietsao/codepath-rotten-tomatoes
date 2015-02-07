//
//  Movie.swift
//  RottenTomatoes
//
//  Created by Jamie Tsao on 2/6/15.
//  Copyright (c) 2015 Jamie Tsao. All rights reserved.
//

import Foundation

/**
 * Model object to represent a Rotten Tomatoe movie entity
 */
class Movie {

    let id: String              // "771318427"
    let title: String           // "Tarzan"
    let year: Int               // 2014
    let rating: String          // "PG"
    let runtime: Int            // 94 (in minutes)
    let criticsScore: Int       // 17
    let audienceScore: Int      // 33
    let synopsis: String        // "A teenage boy raised by ..."
    let posterUrlThumb: String  // "http://content7.flixster.com/movie/11/17/96/11179621_tmb.jpg"
    let abridgedCast: [String]  // ["Anton Zetterholm", "Mark Deklin", ... ]
    
    init(fromJSON movie: Dictionary<String, AnyObject>) {
        id = movie["id"] as String
        title = movie["title"] as String
        year = movie["year"] as Int
        rating = movie["mpaa_rating"] as String
        runtime = movie["runtime"] as Int
        criticsScore = (movie["ratings"] as Dictionary<String, AnyObject>)["critics_score"] as Int
        audienceScore = (movie["ratings"] as Dictionary<String, AnyObject>)["audience_score"] as Int
        synopsis = movie["synopsis"] as String
        posterUrlThumb = (movie["posters"] as Dictionary<String, AnyObject>)["thumbnail"] as String
        // functional programming using closures!
        abridgedCast = (movie["abridged_cast"] as Array<Dictionary<String, AnyObject>>).map { (var actor) -> String in return (actor["name"] as String) }
    }

    func getRuntimeForDisplay() -> String {
        let hours: Int = self.runtime / 60
        let mins: Int = self.runtime % 60
        return (hours > 0 ? "\(hours) hr. " : "") + (mins > 0 ? "\(mins) min." : "")
    }
    
    func getPosterUrlThumbSize() -> String {
        return self.posterUrlThumb;
    }
    
    func getPosterUrlDetailSize() -> String {
        return self.posterUrlThumb.stringByReplacingOccurrencesOfString("tmb", withString: "det")
    }

    func getPosterUrlProfileSize() -> String {
        return self.posterUrlThumb.stringByReplacingOccurrencesOfString("tmb", withString: "pro")
    }

    func getPosterUrlOriginalSize() -> String {
        return self.posterUrlThumb.stringByReplacingOccurrencesOfString("tmb", withString: "ori")
    }

    func getAbridgedCastForDisplay() -> String {
        var display = ""
        for actor in self.abridgedCast {
            display += actor + ", "
        }
        return display.substringToIndex(display.endIndex.predecessor().predecessor())
    }
}