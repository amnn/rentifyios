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
    
    NSDictionary *property = [self.similar               objectAtIndex: indexPath.row ];
    NSUInteger    bedrooms = [[property objectForKey: @"bedroom_count" ] integerValue ];
    
    cell.pID               = [[property objectForKey:            @"id" ] integerValue ];
    
    [[cell textLabel]         setText:                                                        [property objectForKey:@"name" ] ];
    [[cell detailTextLabel]   setText: [NSString stringWithFormat:(bedrooms == 1 ? @"%d Bedroom" : @"%d Bedrooms"), bedrooms ] ];
    
    [self.dataSource addressFor:[[property objectForKey:        @"id" ] integerValue ]
                          atLat:[[property objectForKey:  @"latitude" ]   floatValue ]
                        andLong:[[property objectForKey: @"longitude" ]   floatValue ]
                     toCallback:
     ^( NSString *address ) {
         
         [[cell subtitleTextLabel] setText: address ];
         
         CLLocationCoordinate2D loc = CLLocationCoordinate2DMake( [[property objectForKey:  @"latitude" ] floatValue ],
                                                                  [[property objectForKey: @"longitude" ] floatValue ] );
         
         Property *prop  =         [[Property alloc ] init ];
         prop.coordinate =                               loc;
         prop.name       = [property objectForKey: @"name" ];
         prop.address    =                           address;
         
         [self.mapView addAnnotation: prop ];
         
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
     ^( NSDictionary *data ) {
     
         self.property = [data objectForKey: @"property" ];
         self.similar  = [data objectForKey:  @"similar" ];
         
         NSUInteger bedrooms = [[self.property objectForKey: @"bedroom_count" ] integerValue ];
         
         [self.bedroomsLabel setText: [NSString stringWithFormat: ( bedrooms == 1 ? @"%d Bedroom" : @"%d Bedrooms" ), bedrooms ] ];
         [self.nameLabel     setText:                                                     [self.property objectForKey: @"name" ] ];
         
         CLLocationCoordinate2D center = CLLocationCoordinate2DMake( [[self.property objectForKey:  @"latitude" ] floatValue ],
                                                                     [[self.property objectForKey: @"longitude" ] floatValue ] );
         
         MKCoordinateRegion     region = MKCoordinateRegionMakeWithDistance(                          center, 20000.f, 20000.f );
         
         [self.mapView setRegion: region animated: YES ];
         
         [self.dataSource addressFor:[[self.property objectForKey:        @"id" ] integerValue]
                               atLat:[[self.property objectForKey:  @"latitude" ]   floatValue]
                             andLong:[[self.property objectForKey: @"longitude" ]   floatValue]
                          toCallback:
          ^( NSString *address ){
          
              [self.addressLabel setText: address ];
              Property *property = [[Property alloc] init];
              
              property.name       = [self.property objectForKey: @"name" ];
              property.address    =                                address;
              property.coordinate =                                 center;
              
              [self.mapView addAnnotation: property ];
              
          } ];
         
         [[self.propertyTableViewController tableView ]       reloadData ];
         
         
         
     } ensuring: ^() { [appDelegate globalUnlock]; } ];
    
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
