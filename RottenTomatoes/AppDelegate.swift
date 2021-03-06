//
//  AppDelegate.swift
//  RottenTomatoes
//
//  Created by Jamie Tsao on 2/3/15.
//  Copyright (c) 2015 Jamie Tsao. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        // load storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil);

        // get instance of MovieTableViewController from storyboard and configure for Theater
        let theaterNC = storyboard.instantiateViewControllerWithIdentifier(Constants.IDs.MovieTableNavigationController) as UINavigationController;
        let theaterVC = theaterNC.topViewController as MovieTableViewController
        theaterVC.setViewType(viewType: Constants.MovieViewType.Theater)
        theaterVC.navigationItem.title = Constants.Labels.NavBarTheater
        
        // set title and icon
        theaterNC.tabBarItem = UITabBarItem(title: Constants.Labels.TabBarTheater, image: UIImage(named: Constants.ImageAssets.Theater), tag: 1)
        
        
        // get instance of MovieTableViewController from storyboard and configure for DVD
        let dvdNC = storyboard.instantiateViewControllerWithIdentifier(Constants.IDs.MovieTableNavigationController) as UINavigationController;
        let dvdVC = dvdNC.topViewController as MovieTableViewController
        dvdVC.setViewType(viewType: Constants.MovieViewType.DVD)
        dvdVC.navigationItem.title = Constants.Labels.NavBarDVD
        
        // set title and icon
        dvdNC.tabBarItem = UITabBarItem(title: Constants.Labels.TabBarDVD, image: UIImage(named: Constants.ImageAssets.DVD), tag: 2)

        // set up tab bar controller
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [ theaterNC, dvdNC ]
        window?.rootViewController = tabBarController
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}

