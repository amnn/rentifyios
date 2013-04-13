//
//  PropertyDataSource.m
//  Rentify Property Search
//
//  Created by Ashok Menon on 12/04/2013.
//  Copyright (c) 2013 Ashok Menon. All rights reserved.
//

#import "PropertyDataSource.h"

#define BASE_URL @"http://rentify-property-search.herokuapp.com"

@interface PropertyDataSource ()

- (void)asyncAccessOf:(NSString *)urlString toCallback:( void (^)( id ) ) cb ensuring:( void (^)() ) ensure;

@end

@implementation PropertyDataSource

- (id)init {
    
    self = [super init];
    
    return self;
}

- (void)asyncAccessOf:(NSString *)urlString toCallback:( void (^)( id ) ) cb ensuring:( void (^)() ) ensure {
    
    NSURLRequest *req = [NSURLRequest           requestWithURL: [NSURL URLWithString: urlString ] ];
    
    [NSURLConnection sendAsynchronousRequest:                                                   req
                                       queue:                         [NSOperationQueue mainQueue ]
                           completionHandler: ^( NSURLResponse *res, NSData *data, NSError *err ) {
                               
        if( data ) {
                                   
            NSError *jsonError;
            id obj = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                                   
            if( obj ) cb( obj );
            else NSLog( @"Error parsing JSON: %@",             [jsonError localizedDescription ] );
            
        } else   NSLog( @"Error performing async request: %@", [err       localizedDescription ] );
    
        if( ensure ) ensure();
    }];
    
}

- (void)searchFor:(NSString *)query toCallback:( void (^)( NSArray * ) ) cb ensuring:( void (^)() ) ensure {
    
    [self asyncAccessOf: [BASE_URL stringByAppendingFormat:@"/search/%@.json", query ]
             toCallback: cb
               ensuring: ensure];
    
}

- (void)indexToCallback:( void (^)( NSArray * ) ) cb ensuring:( void (^)() ) ensure {
    
    [self asyncAccessOf: [BASE_URL stringByAppendingString:@"/index.json" ]
             toCallback: cb
               ensuring: ensure ];
    
}

- (void)property:(NSUInteger)pID toCallback:( void (^)( NSDictionary *) ) cb ensuring:( void (^)() ) ensure {
    
    [self asyncAccessOf: [BASE_URL stringByAppendingFormat:@"/property/%d.json", pID ]
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
