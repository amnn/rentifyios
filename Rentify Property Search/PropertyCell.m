//
//  PropertyCell.m
//  Rentify Property Search
//
//  Created by Ashok Menon on 13/04/2013.
//  Copyright (c) 2013 Ashok Menon. All rights reserved.
//

#import "PropertyCell.h"

@implementation PropertyCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
