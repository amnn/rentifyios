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

@property (nonatomic, assign) NSUInteger                    pID;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, assign) NSUInteger               bedrooms;
@property (nonatomic,   copy) NSString                    *name;
@property (nonatomic,   copy) NSString                 *address;

- (NSString *)title;
- (NSString *)subtitle;

+ (Property *)fromJSONObject:(NSDictionary *)json;
+ (NSArray  *)fromJSONObjects:(NSArray *)json;

@end
