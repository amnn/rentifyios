//
//  PropertyDetailViewController.m
//  Rentify Property Search
//
//  Created by Ashok Menon on 18/04/2013.
//  Copyright (c) 2013 Ashok Menon. All rights reserved.
//

#import "MapKit/MapKit.h"
#import "CoreLocation/CoreLocation.h"

#import "PropertyDetailViewController.h"

#import "AppDelegate.h"
#import "PropertyDataSource.h"
#import "PropertyCell.h"
#import "Property.h"
#import "PropertyDetail.h"

@interface PropertyDetailViewController ()

@end

@implementation PropertyDetailViewController

#pragma mark - Data Source Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.similar count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    PropertyCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[PropertyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    
    Property *property = [self.similar objectAtIndex: indexPath.row ];
    cell.pID           =                                 property.pID;
    
    [[cell textLabel]         setText:                                                                                             property.name ];
    [[cell detailTextLabel]   setText: [NSString stringWithFormat:(property.bedrooms == 1 ? @"%d Bedroom" : @"%d Bedrooms"), property.bedrooms ] ];
    
    [self.dataSource addressFor:                  property.pID
                          atLat:  property.coordinate.latitude
                        andLong: property.coordinate.longitude
                     toCallback:
     ^( NSString *address ) {
         
         [[cell subtitleTextLabel] setText: address ];
         property.address =                   address;
         [self.mapView      addAnnotation: property ];
         
     } ];
    
    return cell;
}

#pragma mark - View Lifecycle

- (id)initWithPropertyID:(NSUInteger)pID
{
    
    self = [self initWithNibName:@"PropertyDetailViewController" bundle:[NSBundle mainBundle]];
    
    if( self )
    {
        self.pID = pID;
    }
    
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.dataSource = [PropertyDataSource sharedInstance ];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication ] delegate ];
    
    [appDelegate globalLock];
    
    [self.dataSource property: self.pID
                   toCallback:
     ^( PropertyDetail *data ) {
     
         self.property       =          data.property;
         self.similar        =           data.similar;
         NSUInteger bedrooms = self.property.bedrooms;
         
         [self.bedroomsLabel setText: [NSString stringWithFormat: ( bedrooms == 1 ? @"%d Bedroom" : @"%d Bedrooms" ), bedrooms ] ];
         [self.nameLabel     setText:                                                                         self.property.name ];
         
         MKCoordinateRegion     region = MKCoordinateRegionMakeWithDistance(          self.property.coordinate, 20000.f, 20000.f );
         
         [self.mapView setRegion: region animated: YES ];
         
         [self.dataSource addressFor:                  self.property.pID
                               atLat:  self.property.coordinate.latitude
                             andLong: self.property.coordinate.longitude
                          toCallback:
          ^( NSString *address ){
          
              [self.addressLabel setText:             address ];
              self.property.address =                 address;
              [self.mapView      addAnnotation: self.property ];
              
          } ];
         
         [[self.propertyTableViewController tableView ] reloadData ];
         
         
         
     } ensuring: ^() { [appDelegate globalUnlock]; } ];
    
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
