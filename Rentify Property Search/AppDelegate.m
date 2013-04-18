//
//  AppDelegate.m
//  Rentify Property Search
//
//  Created by Ashok Menon on 12/04/2013.
//  Copyright (c) 2013 Ashok Menon. All rights reserved.
//

// TODO: Property Detail View (with own PropertyTableViewController for whom it is the data source.

#import "QuartzCore/CoreAnimation.h"

#import "AppDelegate.h"

#import "PropertyDataSource.h"
#import "PropertySearchViewController.h"

@implementation AppDelegate

- (void)globalLock {
    if(  self.activityIndicator ) return;
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    [self.activityIndicator                                                setFrame:self.window.frame];
    [self.activityIndicator.layer setBackgroundColor:[[UIColor colorWithWhite:0.0 alpha:0.8] CGColor]];
    
    [self.window         addSubview:self.activityIndicator];
    [self.window              setUserInteractionEnabled:NO];
    [self.activityIndicator setCenter:[self.window center]];
    [self.activityIndicator                 startAnimating];
    
}

- (void)globalUnlock {
    if( !self.activityIndicator ) return;
    
    [self.activityIndicator       stopAnimating];
    [self.activityIndicator removeFromSuperview];
    [self.window  setUserInteractionEnabled:YES];
    
    self.activityIndicator = nil;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window               = [[UIWindow alloc]                       initWithFrame:  [[UIScreen mainScreen] bounds] ];
    self.searchViewController = [[PropertySearchViewController alloc] initWithNibName: @"PropertySearchViewController"
                                                                               bundle:           [NSBundle mainBundle] ];
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController: self.searchViewController ];
    
    
    // Override point for customization after application launch.
    [[navController navigationBar] setHidden:               true ];
    [self.window                  addSubview: navController.view ];
    
    self.window.backgroundColor    = [UIColor whiteColor];
    self.window.rootViewController =        navController;
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
