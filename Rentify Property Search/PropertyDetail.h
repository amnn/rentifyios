//
//  PropertyDetail.h
//  Rentify Property Search
//
//  Created by Ashok Menon on 20/04/2013.
//  Copyright (c) 2013 Ashok Menon. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ParseJSONObjects.h"
#import "Property.h"

@interface PropertyDetail : NSObject
<ParseJSONObjects>

@property (nonatomic, strong) Property *property;
@property (nonatomic, strong) NSArray   *similar;

@end
