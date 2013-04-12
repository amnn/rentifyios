//
//  PropertySearchViewController.m
//  Rentify Property Search
//
//  Created by Ashok Menon on 12/04/2013.
//  Copyright (c) 2013 Ashok Menon. All rights reserved.
//

#import "PropertySearchViewController.h"

@interface PropertySearchViewController ()

@end

@implementation PropertySearchViewController

#pragma mark - Delegate Methods

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog( @"Search Button Pressed" );
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    NSLog( @"Cancel Button Pressed" );
}

#pragma mark - View Lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
