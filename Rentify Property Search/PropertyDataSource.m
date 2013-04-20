//
//  PropertyDataSource.m
//  Rentify Property Search
//
//  Created by Ashok Menon on 12/04/2013.
//  Copyright (c) 2013 Ashok Menon. All rights reserved.
//

#import "CoreLocation/CoreLocation.h"
#import "MapKit/MapKit.h"

#import "PropertyDataSource.h"

#import "GeocoderRequest.h"
#import "ParseJSONObjects.h"
#import "Property.h"
#import "PropertyDetail.h"

#define BASE_URL @"http://rentify-property-search.herokuapp.com"

@interface PropertyDataSource ()

@property (nonatomic, strong) NSMutableDictionary *addressCache;
@property (nonatomic, strong) NSMutableArray      *requestQueue;

@property (nonatomic, strong) CLGeocoder              *geocoder;

- (void)asyncAccessOf: (Class<ParseJSONObjects>) objType at:(NSString *)urlString toCallback:( void (^)( id ) ) cb ensuring:( void (^)() ) ensure;
- (void)serveGeocoderRequests;

@end

@implementation PropertyDataSource

- (id)init {
    
    self = [super init];
    
    self.addressCache  = [[NSMutableDictionary alloc ] initWithCapacity: 1 ];
    self.requestQueue  = [[NSMutableArray      alloc ] initWithCapacity: 1 ];
    self.geocoder      = [[CLGeocoder          alloc ]                init ];
    
    return self;
}

- (void)serveGeocoderRequests {
    static bool serving = false;
    
    if( serving || [self.requestQueue count] == 0 ) return;
    
    serving = true;
    
    GeocoderRequest *req = [self.requestQueue       lastObject ];
    [self.requestQueue                        removeLastObject ];
    
    [self.geocoder reverseGeocodeLocation: req.location
                        completionHandler:
     ^( NSArray *placemarks, NSError *error ){
     
         serving = false;
         CLPlacemark *placemark = [placemarks objectAtIndex: 0 ];
         NSString    *newAddr   = [[placemark.addressDictionary valueForKey: @"FormattedAddressLines" ] componentsJoinedByString: @", " ];
         
         [self.addressCache setObject:                            newAddr
                               forKey: [NSNumber numberWithInt: req.pID ] ];
         
         req.callback(       newAddr );
         [self serveGeocoderRequests ];
         
     } ];
    
}

- (void)addressFor:(NSUInteger)pID atLat:(float) lat andLong:(float) lng toCallback:( void(^)( NSString * ) )cb {
    
    NSNumber *key     = [NSNumber          numberWithInt: pID ];
    NSString *address = [self.addressCache objectForKey:  key ];
    
    if( address ) { cb( address ); return; }
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude: lat longitude: lng ];
    
    [self.requestQueue insertObject:[[GeocoderRequest alloc ] initWithId:      pID
                                                             andLocation: location
                                                             andCallback:       cb ]
                            atIndex: 0 ];
    
    [self serveGeocoderRequests ];
    
}

- (void)asyncAccessOf: (Class<ParseJSONObjects>)objType at:(NSString *)urlString toCallback:( void (^)( id ) ) cb ensuring:( void (^)() ) ensure {
    
    NSURLRequest *req = [NSURLRequest           requestWithURL: [NSURL URLWithString: urlString ] ];
    
    [NSURLConnection sendAsynchronousRequest:                                                   req
                                       queue:                         [NSOperationQueue mainQueue ]
                           completionHandler: ^( NSURLResponse *res, NSData *data, NSError *err ) {
                               
        if( data ) {
                                   
            NSError *jsonError;
            id obj = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                                   
            if( obj ) cb( [objType fromJSONObjects:obj] );
            else NSLog( @"Error parsing JSON: %@",             [jsonError localizedDescription ] );
            
        } else   NSLog( @"Error performing async request: %@", [err       localizedDescription ] );
    
        if( ensure ) ensure();
    }];
    
}

- (void)searchFor:(NSString *)query toCallback:( void (^)( NSArray * ) ) cb ensuring:( void (^)() ) ensure {
    
    [self asyncAccessOf: [Property class]
                     at: [BASE_URL stringByAppendingFormat:@"/search/%@.json", query ]
             toCallback: cb
               ensuring: ensure];
    
}

- (void)indexToCallback:( void (^)( NSArray * ) ) cb ensuring:( void (^)() ) ensure {
    
    [self asyncAccessOf: [Property class]
                     at: [BASE_URL stringByAppendingString:@"/index.json" ]
             toCallback: cb
               ensuring: ensure ];
    
}

- (void)property:(NSUInteger)pID toCallback:( void (^)( PropertyDetail *) ) cb ensuring:( void (^)() ) ensure {
    
    [self asyncAccessOf: [PropertyDetail class]
                     at: [BASE_URL stringByAppendingFormat:@"/property/%d.json", pID ]
             toCallback: cb
               ensuring: ensure ];
    
}

+ (id)sharedInstance {
    
    static PropertyDataSource *shared = nil;
    static dispatch_once_t     once   =   0;
    
    dispatch_once(&once, ^{ shared = [[PropertyDataSource alloc] init]; } );
    
    return shared;
}

@end
