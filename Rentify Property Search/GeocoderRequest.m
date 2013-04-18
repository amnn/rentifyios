//
//  GeocoderRequest.m
//  Rentify Property Search
//
//  Created by Ashok Menon on 18/04/2013.
//  Copyright (c) 2013 Ashok Menon. All rights reserved.
//

#import "GeocoderRequest.h"

@implementation GeocoderRequest

@synthesize pID, location, callback;

- (id)initWithId:(NSUInteger) _pID andLocation:(CLLocation *) _loc andCallback: ( void (^)( NSString * ) ) _cb {
    
    self = [super init];
    if( self ) {
        
        self.pID      = _pID;
        self.location = _loc;
        self.callback =  _cb;
        
    }
    
    return self;
}

@end
