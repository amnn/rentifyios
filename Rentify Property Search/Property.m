//
//  Property.m
//  Rentify Property Search
//
//  Created by Ashok Menon on 19/04/2013.
//  Copyright (c) 2013 Ashok Menon. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

#import "Property.h"

@implementation Property

- (NSString *)title    { return    self.name; }
- (NSString *)subtitle { return self.address; }

@end
