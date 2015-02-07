//
//  RottenTomatoesAPI.swift
//  RottenTomatoes
//
//  Created by Jamie Tsao on 2/6/15.
//  Copyright (c) 2015 Jamie Tsao. All rights reserved.
//

import Foundation

/**
* Rotten Tomatoes API Client
*/
class RottenTomatoesAPI {
    
    //
    // Movie endpoints
    //
    
    class func getMoviesBoxOffice(successCallback sc: ([Movie]) -> Void, errorCallback ec: () -> Void) {
        invokeAPI("http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json", successCallback: sc, errorCallback: ec)
    }
    
    class func getMoviesInTheaters(successCallback sc: ([Movie]) -> Void, errorCallback ec: () -> Void) {
        invokeAPI("http://api.rottentomatoes.com/api/public/v1.0/lists/movies/in_theaters.json", successCallback: sc, errorCallback: ec)
    }
    
    class func getMoviesOpening(successCallback sc: ([Movie]) -> Void, errorCallback ec: () -> Void) {
        invokeAPI("http://api.rottentomatoes.com/api/public/v1.0/lists/movies/opening.json", successCallback: sc, errorCallback: ec)
    }
    
    class func getMoviesUpcoming(successCallback sc: ([Movie]) -> Void, errorCallback ec: () -> Void) {
        invokeAPI("http://api.rottentomatoes.com/api/public/v1.0/lists/movies/upcoming.json", successCallback: sc, errorCallback: ec)
    }
    
    //
    // DVD endpoints
    //
    
    class func getDVDsTopRentals(successCallback sc: ([Movie]) -> Void, errorCallback ec: () -> Void) {
        invokeAPI("http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json", successCallback: sc, errorCallback: ec)
    }
    
    class func getDVDsCurrentReleases(successCallback sc: ([Movie]) -> Void, errorCallback ec: () -> Void) {
        invokeAPI("http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/current_releases.json", successCallback: sc, errorCallback: ec)
    }
    
    class func getDVDsNewReleases(successCallback sc: ([Movie]) -> Void, errorCallback ec: () -> Void) {
        invokeAPI("http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/new_releases.json", successCallback: sc, errorCallback: ec)
    }
    
    class func getDVDsUpcoming(successCallback sc: ([Movie]) -> Void, errorCallback ec: () -> Void) {
        invokeAPI("http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/upcoming.json", successCallback: sc, errorCallback: ec)
    }
    
    //
    // Generic Helper
    //
    
    class func invokeAPI(url: String, successCallback sc: ([Movie]) -> Void, errorCallback ec: () -> Void) {
        
        let params = ["apikey": "nz3fyh3ybxp3pfrxz34axwaf"]
        
        let manager = AFHTTPRequestOperationManager()
        manager.GET(url, parameters: params,
            success: { (operation, responseObject) -> Void in
                var results: [NSDictionary] = (responseObject["movies"] as [NSDictionary]?) ?? []
                var movies: [Movie] = []
                for result in results {
                    movies.append(Movie(fromJSON: result as Dictionary))
                }
                sc(movies)
            },
            failure: { (operation, requestError) -> Void in
                ec()
            }
        )
    }
    
}
