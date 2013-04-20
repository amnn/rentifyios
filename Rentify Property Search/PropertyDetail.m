//
//  PropertyDetail.m
//  Rentify Property Search
//
//  Created by Ashok Menon on 20/04/2013.
//  Copyright (c) 2013 Ashok Menon. All rights reserved.
//

#import "PropertyDetail.h"

#import "Property.h"

@implementation PropertyDetail

+ (PropertyDetail *)fromJSONObjects:(NSDictionary *)json
{
    PropertyDetail *detail = [[PropertyDetail alloc] init];
    
    detail.property = [Property fromJSONObject:  [json objectForKey: @"property" ] ];
    detail.similar  = [Property fromJSONObjects: [json objectForKey:  @"similar" ] ];
    
    return detail;
}

@end
