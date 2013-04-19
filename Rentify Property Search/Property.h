//
//  Property.h
//  Rentify Property Search
//
//  Created by Ashok Menon on 19/04/2013.
//  Copyright (c) 2013 Ashok Menon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>


@interface Property : NSObject
<MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic,   copy) NSString                    *name;
@property (nonatomic,   copy) NSString                 *address;

- (NSString *)title;
- (NSString *)subtitle;

@end
