//
//  PropertyDataSource.h
//  Rentify Property Search
//
//  Created by Ashok Menon on 12/04/2013.
//  Copyright (c) 2013 Ashok Menon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PropertyDataSource : NSObject

- (id)init;

- (void)searchFor:(NSString *)query toCallback:( void (^)( NSArray      * ) ) cb ensuring:( void (^)() ) ensure;
- (void)indexToCallback:                       ( void (^)( NSArray      * ) ) cb ensuring:( void (^)() ) ensure;
- (void)property:(NSUInteger)pID    toCallback:( void (^)( NSDictionary * ) ) cb ensuring:( void (^)() ) ensure;

+ (id)sharedInstance;

@end
