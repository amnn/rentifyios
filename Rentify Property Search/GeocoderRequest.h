//
//  GeocoderRequest.h
//  Rentify Property Search
//
//  Created by Ashok Menon on 18/04/2013.
//  Copyright (c) 2013 Ashok Menon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreLocation/CoreLocation.h"
#import "MapKit/MapKit.h"

@interface GeocoderRequest : NSObject

@property (nonatomic, assign) NSUInteger                 pID;
@property (nonatomic,   copy) CLLocation           *location;
@property (nonatomic,   copy) void (^callback)( NSString * );

- (id)initWithId:(NSUInteger) _pID andLocation:(CLLocation *) _loc andCallback: ( void (^)( NSString * ) ) _cb;

@end
