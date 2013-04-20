//
//  ParseJSONObjects.h
//  Rentify Property Search
//
//  Created by Ashok Menon on 20/04/2013.
//  Copyright (c) 2013 Ashok Menon. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ParseJSONObjects <NSObject>

@required

+ (id)fromJSONObjects:(id)json;

@end
