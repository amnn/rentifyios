//
//  PropertyDetailViewController.h
//  Rentify Property Search
//
//  Created by Ashok Menon on 18/04/2013.
//  Copyright (c) 2013 Ashok Menon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

#import "PropertyDataSource.h"
#import "PropertyTableViewController.h"

@interface PropertyDetailViewController : UIViewController

@property (nonatomic, assign) NSUInteger                 pID;
@property (nonatomic, strong) PropertyDataSource *dataSource;
@property (nonatomic, strong) Property             *property;
@property (nonatomic, strong) NSArray               *similar;

@property (nonatomic, strong) IBOutlet PropertyTableViewController *propertyTableViewController;

@property (nonatomic, strong) IBOutlet MKMapView        *mapView;
@property (nonatomic, strong) IBOutlet UILabel        *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel     *addressLabel;
@property (nonatomic, strong) IBOutlet UILabel    *bedroomsLabel;

- (id)initWithPropertyID:(NSUInteger)pID;

@end
