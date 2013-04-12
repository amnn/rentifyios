//
//  PropertyDataSource.m
//  Rentify Property Search
//
//  Created by Ashok Menon on 12/04/2013.
//  Copyright (c) 2013 Ashok Menon. All rights reserved.
//

#import "PropertyDataSource.h"

@implementation PropertyDataSource

- (id)init {
    
    self = [super init];
    
    if( self )
    {
        
    }
    
    return self;
}

+ (id)sharedInstance {
    
    static PropertyDataSource *shared = nil;
    static dispatch_once_t     once   =   0;
    
    dispatch_once(&once, ^{ shared = [[PropertyDataSource alloc] init]; } );
    
    return shared;
}

@end
