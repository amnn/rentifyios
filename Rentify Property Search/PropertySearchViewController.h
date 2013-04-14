//
//  PropertySearchViewController.h
//  Rentify Property Search
//
//  Created by Ashok Menon on 12/04/2013.
//  Copyright (c) 2013 Ashok Menon. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PropertyTableViewController.h"
#import "PropertyDataSource.h"

@interface PropertySearchViewController : UIViewController
<UISearchBarDelegate, UITableViewDataSource>

@property ( nonatomic,            strong ) IBOutlet PropertyTableViewController *propertyTableViewController;
@property ( nonatomic,            strong ) NSArray                                                *tableData;
@property ( nonatomic, unsafe_unretained ) PropertyDataSource                                    *dataSource;

@end
