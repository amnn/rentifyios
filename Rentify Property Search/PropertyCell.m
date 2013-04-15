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
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.subtitleTextLabel = [[UILabel alloc]     initWithFrame: CGRectMake( 10.f, 36.f, 310.f, 20.f ) ];
        
        [self.subtitleTextLabel setFont: [UIFont fontWithName:@"Helvetica" size:[UIFont systemFontSize ] ] ];
        [self.subtitleTextLabel setTextColor:                                         [UIColor grayColor ] ];
        [self                   addSubview:                                         self.subtitleTextLabel ];
        
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    NSLog( @"%.2f %.2f %.2f %.2f", self.detailTextLabel.frame.origin.x, self.detailTextLabel.frame.origin.y, self.detailTextLabel.frame.size.width, self.detailTextLabel.frame.size.height );
    
    self.textLabel.frame       = CGRectMake(                   10.f, 10.f, 320.f, 20.f );
    self.detailTextLabel.frame = CGRectMake( self.detailTextLabel.frame.origin.x, 10.f,
                                                 self.detailTextLabel.frame.size.width,
                                                self.detailTextLabel.frame.size.height );
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
