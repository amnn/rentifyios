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

+ (Property *)fromJSONObject:(NSDictionary *)json
{
    Property *prop = [[Property alloc ] init ];
    
    prop.pID        =                             [[json objectForKey:            @"id" ] integerValue ];
    prop.coordinate = CLLocationCoordinate2DMake( [[json objectForKey:      @"latitude" ]   floatValue ],
                                                  [[json objectForKey:     @"longitude" ]   floatValue ] );
    prop.bedrooms   =                             [[json objectForKey: @"bedroom_count" ] integerValue ];
    prop.name       =                             [json  objectForKey:          @"name" ];
    
    return prop;
}

+ (NSArray  *)fromJSONObjects:(NSArray *)json
{
    
    NSMutableArray *properties = [[NSMutableArray alloc ] initWithCapacity: 1 ];
    
    for ( NSDictionary *obj in json ) [properties addObject: [Property fromJSONObject: obj ] ];
    
    return properties;
}

@end
