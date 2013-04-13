//
//  AppDelegate.h
//  Rentify Property Search
//
//  Created by Ashok Menon on 12/04/2013.
//  Copyright (c) 2013 Ashok Menon. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PropertySearchViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

- (void)globalLock;
- (void)globalUnlock;

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) PropertySearchViewController *searchViewController;

@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;

@end
