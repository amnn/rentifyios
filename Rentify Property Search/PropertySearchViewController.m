//
//  PropertySearchViewController.m
//  Rentify Property Search
//
//  Created by Ashok Menon on 12/04/2013.
//  Copyright (c) 2013 Ashok Menon. All rights reserved.
//

#import "QuartzCore/CoreAnimation.h"

#import "AppDelegate.h"

#import "PropertySearchViewController.h"
#import "PropertyTableViewController.h"
#import "PropertyDataSource.h"

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

#pragma mark - Data Source Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    
    NSDictionary *property = [self.tableData objectAtIndex:indexPath.row];

    [[cell textLabel] setText:[property objectForKey:@"name"] ];
    
    return cell;
}

#pragma mark - View Lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if ( self ) {
    
        self.dataSource = [PropertyDataSource sharedInstance];
        
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    [appDelegate globalLock];
    
    [self.dataSource indexToCallback: ^( NSArray *properties ) {
        
        self.tableData = properties;
        
        [[self.propertyTableViewController tableView ] reloadData ];
        
    } ensuring: ^(){ [appDelegate globalUnlock]; }];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
